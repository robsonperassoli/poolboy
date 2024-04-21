import gleeunit/should
import nakai/attr
import poolboy/buttons

pub fn merge_attrs_test() {
  buttons.merge_attrs([attr.class("bg-white")], [attr.class("p-4")])
  |> should.equal([attr.class("bg-white p-4")])

  buttons.merge_attrs([], [attr.class("p-4")])
  |> should.equal([attr.class("p-4")])

  buttons.merge_attrs([attr.class("bg-white")], [])
  |> should.equal([attr.class("bg-white")])
}
