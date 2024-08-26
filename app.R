
source("libraries.R")
source("readData.R")
source("plotData.R")

ui <- fluidPage(
    
    titlePanel("ΙΝΑΒ recording of environmental (temperature and humidity) parameters"),
    
    actionButton("reload", "Reload"), br(),
    h4(textOutput("reloadTimeText")), br(),
    navset_card_underline(
        
        # 1 -------------------------
        nav_panel("Overview", plotOutput("overviewPlot", height = "850px")),
        
        # 2 -------------------------
        nav_panel("ComputerRoom", echarts4rOutput("computerRoomPlot", height = "850px")),
        
        # 3 -------------------------
        nav_panel("DeepFreezersRoom", echarts4rOutput("deepFreezersRoomPlot", height = "850px")),
        nav_panel("deepFreezer5", echarts4rOutput("deepFreezer5Plot", height = "850px")),
        nav_panel("deepFreezer6", echarts4rOutput("deepFreezer6Plot", height = "850px")),
        nav_panel("deepFreezer7", echarts4rOutput("deepFreezer7Plot", height = "850px")),
        nav_panel("deepFreezer8", echarts4rOutput("deepFreezer8Plot", height = "850px")),
        nav_panel("deepFreezer9", echarts4rOutput("deepFreezer9Plot", height = "850px")),
        
        # 4 -------------------------
        nav_panel("freezerA", echarts4rOutput("freezerAPlot", height = "850px")),
        nav_panel("freezerC", echarts4rOutput("freezerCPlot", height = "850px")),
        nav_panel("freezerD", echarts4rOutput("freezerDPlot", height = "850px")),
        nav_panel("freezerE", echarts4rOutput("freezerEPlot", height = "850px")),
        
        # 5 -------------------------
        nav_panel("Office122A", echarts4rOutput("Office122APlot", height = "850px")),
        nav_panel("Office122B", echarts4rOutput("Office122BPlot", height = "850px")),
        nav_panel("Office122C", echarts4rOutput("Office122CPlot", height = "850px")),
        nav_panel("Office214B", echarts4rOutput("Office214BPlot", height = "850px")),
        nav_panel("Office215C", echarts4rOutput("Office215CPlot", height = "850px"))
    )
)

server <- function(input, output) {
    
    db <- connectToMongoDB()
    
    v <- reactiveValues(
        time = Sys.time() |> as.character() |> str_split_i("\\.", 1),
        data = readSensorData(db)
    )
    
    observeEvent(input$reload, {
        v$data <- readSensorData(db)
        v$time <- Sys.time() |> as.character() |> str_split_i("\\.", 1)
    })
    
    output$reloadTimeText <- renderText({
        if (is.null(v$time)) return()
        paste0("Last updated on ", v$time)
    })
    
    # 1 ----------------
    output$overviewPlot <- renderPlot({
        if (is.null(v$data)) return()
        plotOverview(v$data)
    })
    
    # 2 ----------------
    output$computerRoomPlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "ComputerRoom")
    })
    
    # 3 ----------------
    output$deepFreezersRoomPlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "DeepFreezersRoom")
    })
    output$deepFreezer5Plot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "deepFreezer5")
    })
    output$deepFreezer6Plot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "deepFreezer6")
    })
    output$deepFreezer7Plot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "deepFreezer7")
    })
    output$deepFreezer8Plot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "deepFreezer8")
    })
    output$deepFreezer9Plot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "deepFreezer9")
    })
    
    # 4 ----------------
    output$freezerAPlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "freezerA")
    })
    output$freezerCPlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "freezerC")
    })
    output$freezerDPlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "freezerD")
    })
    output$freezerEPlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "freezerE")
    })
    
    # 5 ----------------
    output$Office122APlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "Office122A")
    })
    output$Office122BPlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "Office122B")
    })
    output$Office122CPlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "Office122C")
    })
    output$Office214BPlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "Office214B")
    })
    output$Office215CPlot <- renderEcharts4r({
        if (is.null(v$data)) return()
        plotRoom(v$data, "Office215C")
    })
}

shinyApp(ui = ui, server = server)
