import gleam/dynamic
import gleam/int
import gleam/io
import gleam/list

import sqlight.{type Connection}

pub type Pool {
  Pool(id: Int, volume: Int)
}

pub fn create_pool(volume: Int, db: Connection) {
  let sql =
    "insert into pools(volume) values (" <> int.to_string(volume) <> ");"

  sqlight.exec(sql, db)
}

pub fn update_pool(id: Int, volume: Int) {
  todo
}

pub fn delete_pool(id: Int) {
  todo
}

pub fn get_pools(db: sqlight.Connection) {
  let sql = "select * from pools;"

  let pool_decoder = dynamic.tuple2(dynamic.int, dynamic.int)

  let assert Ok(rows) =
    sqlight.query(sql, on: db, with: [], expecting: pool_decoder)

  rows
  |> list.map(fn(row) { Pool(id: row.0, volume: row.1) })
}
