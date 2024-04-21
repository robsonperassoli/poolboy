import gleam/string_builder.{type StringBuilder}
import nakai
import nakai/html
import poolboy/template

pub fn render() -> StringBuilder {
  html.Fragment([html.h1_text([], "Welcome Poolboy")])
  |> template.wrap()
  |> nakai.to_string_builder()
}
