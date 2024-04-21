import gleam/dict
import gleam/list
import gleam/string
import nakai/attr.{type Attr}
import nakai/html.{type Node}

const button_class = "py-2 px-3 border rounded-md hover:bg-gray-50 text-gray-900"

pub fn button(attrs: List(Attr), nodes: List(Node)) -> Node {
  html.button(merge_attrs([attr.class(button_class)], attrs), nodes)
}

pub fn button_text(attrs: List(Attr), text: String) -> Node {
  html.button_text(merge_attrs([attr.class(button_class)], attrs), text)
}

pub fn merge_attrs(attrs: List(Attr), attrs2: List(Attr)) -> List(Attr) {
  [attrs, attrs2]
  |> list.concat()
  |> list.group(fn(a: Attr) { a.name })
  |> dict.fold([], fn(acc, name, values) {
    let combined_values =
      list.fold(values, "", fn(acc_v, attr) { attr.value <> " " <> acc_v })
      |> string.trim()

    [attr.Attr(name: name, value: combined_values), ..acc]
  })
}
