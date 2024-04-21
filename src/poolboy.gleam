import gleam/erlang/process
import mist
import wisp
import poolboy/router
import tailwind

pub fn main() {
  wisp.configure_logger()

  let secret_key_base = wisp.random_string(64)

  let assert Ok(_) =
    [
      "--config=tailwind.config.js", "--input=./src/css/app.css",
      "--output=./priv/static/css/app.css",
    ]
    |> tailwind.run()

  let assert Ok(_) =
    wisp.mist_handler(router.handle_request, secret_key_base)
    |> mist.new()
    |> mist.port(8000)
    |> mist.start_http()

  process.sleep_forever()
}
