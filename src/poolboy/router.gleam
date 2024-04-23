import gleam/http.{Get, Post}
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/result
import gleam/string_builder
import nakai
import poolboy/pages/home
import poolboy/pages/pool_setup.{Form}
import poolboy/pools
import poolboy/web
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, ctx: web.Context) -> Response {
  use req <- web.middleware(req)

  case wisp.path_segments(req) {
    [] -> home(req)
    ["pool", "setup"] -> pool_setup(req, ctx)
    ["comments"] -> comments(req)
    ["comments", id] -> show_comment(req, id)
    _ -> wisp.not_found()
  }
}

fn home(req: Request) -> Response {
  use <- wisp.require_method(req, Get)

  let html = home.render()

  wisp.ok()
  |> wisp.html_body(html)
}

fn pool_setup(req: Request, ctx: web.Context) -> Response {
  case req.method {
    Get -> get_pool_setup(req, ctx)
    Post -> post_pool_setup(req, ctx)
    _ -> wisp.method_not_allowed([Get, Post])
  }
}

fn get_pool_setup(_req: Request, ctx: web.Context) -> Response {
  let html = pool_setup.render()

  let res = pools.get_pools(ctx.db)
  io.debug(res)

  wisp.ok()
  |> wisp.html_body(html)
}

fn post_pool_setup(req: Request, ctx: web.Context) -> Response {
  use formdata <- wisp.require_form(req)

  let form_parse = {
    use volume_str <- result.try(list.key_find(formdata.values, "volume"))
    use volume <- result.try(int.parse(volume_str))

    Ok(volume)
  }

  let volume = result.unwrap(form_parse, 0)

  let create_result = pools.create_pool(volume, ctx.db)

  // case create_result {
  //   Error(e) -> {
  //     io.debug(e)
  //     ""
  //   }
  //   Ok(_) -> {
  //     io.debug("success")
  //     ""
  //   }
  // }

  let form_values = Form(volume: "", error: Some("Volume is required."))

  let html =
    form_values
    |> pool_setup.form()
    |> nakai.to_inline_string_builder()

  wisp.ok()
  |> wisp.html_body(html)
}

fn comments(req: Request) -> Response {
  case req.method {
    Get -> list_comments()
    Post -> create_comment(req)
    _ -> wisp.method_not_allowed([Get, Post])
  }
}

fn list_comments() -> Response {
  let html = string_builder.from_string("Comments!!!!")
  wisp.ok()
  |> wisp.html_body(html)
}

fn create_comment(_req: Request) -> Response {
  let html = string_builder.from_string("Created!!!")

  wisp.created()
  |> wisp.html_body(html)
}

fn show_comment(req: Request, id: String) -> Response {
  use <- wisp.require_method(req, Get)

  let html = string_builder.from_string("Comment with id: " <> id)
  wisp.ok()
  |> wisp.html_body(html)
}
