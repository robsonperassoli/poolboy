import gleam/erlang/process
import mist
import poolboy/router
import poolboy/web
import sqlight
import tailwind
import wisp

pub fn main() {
  wisp.configure_logger()

  let secret_key_base = wisp.random_string(64)
  use conn <- sqlight.with_connection("data/db.sqlite")

  let assert Ok(_) =
    [
      "--config=tailwind.config.js", "--input=./src/css/app.css",
      "--output=./priv/static/css/app.css",
    ]
    |> tailwind.run()

  let context = web.Context(db: conn)

  let handler = router.handle_request(_, context)

  let assert Ok(_) =
    handler
    |> wisp.mist_handler(secret_key_base)
    |> mist.new()
    |> mist.port(8000)
    |> mist.start_http()

  process.sleep_forever()
}
