import nakai/attr
import nakai/html.{type Node}

pub fn wrap(content: Node) {
  html.Html([], [
    html.Head([
      html.title("Poolboy"),
      html.meta([
        attr.name("viewport"),
        attr.content("width=device-width, initial-scale=1.0"),
      ]),
      html.link([attr.href("/public/css/app.css"), attr.rel("stylesheet")]),
      html.link([
        attr.href("https://fonts.googleapis.com"),
        attr.rel("preconnect"),
      ]),
      html.link([
        attr.href("https://fonts.gstatic.com"),
        attr.rel("preconnect"),
        attr.crossorigin(),
      ]),
      html.link([
        attr.href(
          "https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap",
        ),
        attr.rel("stylesheet"),
      ]),
    ]),
    html.Body([attr.class("bg-gray-100")], [
      html.div([attr.class("w-full max-w-screen-xl mx-auto p-6")], [
        html.header([], [
          html.nav([], [
            html.ul([attr.class("flex gap-x-4 py-4 font-medium")], [
              menu_item("/", "Home"),
              menu_item("/pool/setup", "Setup Pool"),
            ]),
          ]),
        ]),
        content,
      ]),
      html.Element(
        "script",
        [attr.src("https://unpkg.com/htmx.org@1.9.11")],
        [],
      ),
    ]),
  ])
}

fn menu_item(href: String, text: String) -> Node {
  html.li([], [
    html.a_text(
      [attr.href(href), attr.class("hover:text-gray-700 hover:underline")],
      text,
    ),
  ])
}
