sqlLite_objects <- list(
  
  connect_function = function(user,pw){
    chemin_IPPAP_dev <- "~/CERISE/02-Espace-de-Production/090_Prix/9010_IPPAP/IPPAP_app/dev/App/donnees/IPPAP.sqlite"
    db_IPPAP <- dbConnect(RSQLite::SQLite(), dbname = chemin_IPPAP_dev)
    return(db_IPPAP)
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
