

connectToMongoDB <- function(
        url = "mongodb://160.40.71.110:27017/SensorData", 
        collection = "EnvData", 
        db = "SensorData") {
    
    d <- mongo(url = url, collection = collection, db = db)
    
    return(d)
    
}

readSensorData <- function(db, filterTime = 7 * 24) {
        
    cutoff <- (Sys.time() - hours(filterTime)) |> force_tz("GMT")
    
    d <- db$find() |> setDT()
    
    d$time <- d$time |> with_tz(tzone = "GMT")
    
    d$db   <- d$topic |> str_split_i("\\/", 2)
    d$room <- d$topic |> str_split_i("\\/", 3)
    d$type <- d$topic |> str_split_i("\\/", 4)
    
    d <- d[which(time >= cutoff), ]
    
    return(d)
}
