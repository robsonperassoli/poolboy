import nakai/attr.{type Attr}

pub fn hx_get(value: String) -> Attr {
  hx("get", value)
}

pub fn hx_post(value: String) -> Attr {
  hx("post", value)
}

pub fn hx_put(value: String) -> Attr {
  hx("put", value)
}

pub fn hx_delete(value: String) -> Attr {
  hx("delete", value)
}

pub fn hx_swap(value: String) -> Attr {
  hx("swap", value)
}

pub fn hx(name: String, value: String) -> Attr {
  attr.Attr(name: "hx-" <> name, value: value)
}
