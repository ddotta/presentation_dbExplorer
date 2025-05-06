sqlLite_objects <- list(

  connect_function = function(user,pw){
    con_sqlite <- dbConnect(RSQLite::SQLite(), ":memory:")
    dbWriteTable(con_sqlite, "mtcars", mtcars)
    dbWriteTable(con_sqlite, "CO2", data.frame(CO2))
    dbWriteTable(con_sqlite, "billboard", data.frame(tidyr::billboard))
    return(con_sqlite)
  },

  req_login = FALSE,

  list_schemas_function = function(con){
    return('default')
  },

  list_tables_function = function(con,dbname){
    tables <- dbGetQuery(con, "SELECT name FROM sqlite_master WHERE type='table'")
    return(tables)
  },

  remote_table_function = function(con,dbname,tablename){
    lz <- dplyr::tbl(con, tablename)
  }

)

connectors <- list("SQLite DB"=sqlLite_objects)
