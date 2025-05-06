exportPgToParquet <- function(con,table,outpath="./data/"){
  
  start_time <- Sys.time()
  dep_schemas <- dbGetQuery(con,"select nspname as name from pg_catalog.pg_namespace")$name
  dep_schemas <- dep_schemas[dep_schemas %in% c("balsav2")]
  
  cat(glue::glue("Export parquet de la table {crayon::bold$blue(table)} : Chargement en mémoire depuis Postgre ..."))
  tbl_list <- purrr::map(dep_schemas,function(schema){
    
    tbl <- tbl(con,in_schema(schema,table))
    
  })
  data_all_schema <- tbl_list %>% purrr::reduce(dplyr::union_all) %>% collect()
  
  cat(glue::glue("{crayon::bold$green(\"Ok\")}, Ecriture des fichiers parquet..."))
  
  chemin_export <- "~/CERISE/00-Espace-Personnel/damien.dotta/dbExplorer_test/data/export_parquet/data/export_parquet/"
  
  if (!dir.exists("/data/export_parquet/")) {
    dir.create(chemin_export, recursive = TRUE)
  }
  
  data_all_schema %>% arrow::write_parquet(
    sink = paste0(chemin_export,table,".parquet")
  )
  
  end_time <- Sys.time()
  cat(glue::glue("{crayon::bold$green(\"Ok\")} duration: {round(difftime(time1 =end_time,time2 = start_time,units = \"secs\"),0)} sec \n\n"))
}
