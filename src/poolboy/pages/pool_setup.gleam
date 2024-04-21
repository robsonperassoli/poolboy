import gleam/option.{type Option, None, Some}
import gleam/string_builder.{type StringBuilder}
import nakai
import nakai/attr
import nakai/html
import poolboy/buttons
import poolboy/htmx
import poolboy/template

pub type Form {
  Form(volume: String, error: Option(String))
}

pub fn render() -> StringBuilder {
  html.Fragment([empty_form()])
  |> template.wrap()
  |> nakai.to_string_builder()
}

pub fn empty_form() {
  form(Form(volume: "", error: None))
}

pub fn form(form: Form) {
  let error = case form.error {
    None -> []
    Some(error) -> [html.p_text([attr.class("text-sm text-red-500")], error)]
  }

  html.form(
    [
      attr.class("bg-white space-y-4 p-6 border rounded-lg shadow-sm"),
      htmx.hx_post("/pool/setup"),
      htmx.hx_swap("outerHTML"),
    ],
    [
      html.label([attr.class("space-y-1")], [
        html.span_text(
          [attr.class("block text-sm")],
          "Pool size (cubic meters):",
        ),
        html.input([
          attr.type_("number"),
          attr.value(form.volume),
          attr.name("volume"),
          attr.class("rounded-md border text-gray-900 border-gray-300 text-sm"),
        ]),
        html.Fragment(error),
      ]),
      html.div([attr.class("block")], [
        buttons.button_text([attr.class("block w-40")], "Save"),
      ]),
    ],
  )
}
