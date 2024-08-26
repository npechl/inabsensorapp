


plotOverview <- function(x) {
    
    x |>
        ggplot(aes(time, value)) +
        geom_line(aes(group = type, color = type)) +
        scale_color_manual(values = c(c("#00429d", "#008493"))) +
        
        facet_wrap(vars(room), scales = "free_y") +
        
        theme_minimal() +

        theme(
            strip.text = element_text(face = "bold", size = 12),
            axis.text = element_text(face = "bold", size = 12),
            axis.title = element_text(face = "bold", size = 12),

            legend.title = element_text(face = "bold", size = 12),
            legend.text = element_text(face = "bold", size = 12),
            
            axis.line = element_line(),
            axis.ticks = element_line()
        )
    
}

plotRoom <- function(x, room_name) {
    
    if(room_name %in% c("Office122A", "Office122B", "Office122C", "Office214B", "Office215C")) {
        
        o <- x[which(room == room_name)] |>
            group_by(type) |> 
            e_charts(x = time) |>
            e_line(value, showSymbol = FALSE) |>
            e_mark_line(c("temp"), data = list(yAxis = 8)) |>
            e_color(c("#00429d", "#008493")) |> 
            e_tooltip(trigger = "axis")
        
    } else if(room_name %in% c("freezerA", "freezerC", "freezerD", "freezerE")) {
        
        o <- x[which(room == room_name)] |>
            group_by(type) |> 
            e_charts(x = time) |>
            e_line(value, showSymbol = FALSE) |>
            e_mark_line(c("temp"), data = list(yAxis = -20)) |>
            e_mark_line(c("temp"), data = list(yAxis = -25)) |>
            e_color(c("#008493")) |> 
            e_tooltip(trigger = "axis")
        
    } else if(room_name %in% c("deepFreezer5", "deepFreezer6", "deepFreezer7", "deepFreezer8", "deepFreezer9")) {
        
        o <- x[which(room == room_name)] |>
            group_by(type) |> 
            e_charts(x = time) |>
            e_line(value, showSymbol = FALSE) |>
            e_mark_line(c("temp"), data = list(yAxis = -67)) |>
            e_mark_line(c("temp"), data = list(yAxis = -80)) |>
            e_color(c("#008493")) |> 
            e_tooltip(trigger = "axis")
        
    } else {
        
        o <- x[which(room == room_name)] |>
            group_by(type) |> 
            e_charts(x = time) |>
            e_line(value, showSymbol = FALSE) |>
            e_mark_line(c("temp"), data = list(yAxis = 18)) |>
            e_mark_line(c("temp"), data = list(yAxis = 27)) |>
            e_mark_line(c("humi"), data = list(yAxis = 30)) |>
            e_mark_line(c("humi"), data = list(yAxis = 70)) |>
            e_color(c("#00429d", "#008493")) |> 
            e_tooltip(trigger = "axis")
        
    }
    
    return(o)
    
}