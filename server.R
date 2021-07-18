

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    df_filter <- reactive({
        df %>%
            filter(neighbourhood_group %in% input$select_city,
                   room_type %in% input$room_types)
    })

    output$dumbbel <- renderPlotly({

        p1 <- df_filter() %>%
            ggplot(aes(y = reorder(neighbourhood,max))) +
            geom_linerange(aes(xmin = min, xmax = max),linetype = 1, color = "red") +
            geom_point(aes(x = min), size = 3, color = "blue") +
            geom_point(aes(x = max), size = 3, color = "blue") +
            labs(title = "Range Price between Neighbourhood",
                 x = "Price in USD",
                 y = "City",
                 color = "neighbourhood") +
            theme(
                panel.background = element_rect(fill = "white"),
                panel.grid.major = element_line(colour = "gray80"),
                panel.grid.minor = element_blank(),
                plot.title = element_text(family = "serif",
                                          size = 18)
            )

        ggplotly(p1)
    })



    #render base map

    map_base <- reactive({
        draw_base_map()
    })


    output$mapdeck <- renderMapdeck({
        map_base()
    })

    sf_reactive <- reactive({
        choose_obs(input$viz)
    })

    observe({
        update_map("mapdeck", sf_reactive(), input$viz)

    })

    #dataset
    output$data_table <- DT::renderDataTable({

        DT::datatable(nyc_airbnb,
                      options = list(scrollX = T))
    })


    #Download
    output$download <- downloadHandler(
        filename = function() {paste("data-", Sys.Date(), ".csv", sep = "")},
        content = function(file) {
            write.csv(nyc_airbnb, file, row.names = F)
        })


    })





