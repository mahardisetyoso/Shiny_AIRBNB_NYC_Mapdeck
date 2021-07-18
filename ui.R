
shinyUI(



    navbarPage( title = "AIRBNB Data Visualization",

    						theme = shinytheme("spacelab"),

    						tabPanel("Introduction", h1(HTML('<img src = "https://www.wallpapertip.com/wmimgs/40-409339_new-york-city-night-visual-effect-wallpaper-src.jpg" width=1750 height=650')),

    										 h2("Introduction"),
    										 p("This simple Shiny Dashboard is my first project about How to use R package over AIRBNB data in New York City. R is powerful programming languang to both visualize and analyze.
    										 	This web analytical dashboard try to show that there is simple ways using R in to create analytic product. several R library package is used for exploratory data analytic and spatial visualization such as dplyr, sf, and mapdeck.
    										 	FYI I reccomend Mapdeck to visualize spatial data beautifully. Constructive feedback over my first web analytical design and content will be much appreciated, you may support me through my linkedin or github on About tab. Big Thanks!", style = "font-family: 'times'; font-si16pt; font-size:25px"),

    										 ),


    						tabPanel("Map",

    										 div(class = "outer",tags$head(includeCSS("styles.css")),

    										 mapdeckOutput("mapdeck", height = "100%", width = "100%")),



    										 absolutePanel(

    										 	id = "hist_panel",
    										 	class = "panel panel-default",
    										 	top = 60,
    										 	left = "auto",
    										 	right = 0,
    										 	bottom = "auto",
    										 	width = "20%",
    										 	height = "auto",
    										 	draggable = TRUE,
    										 	fixed = TRUE,

    										 	h5(HTML("Select Option to choose POI Visualization from Mapdeck Package Librarry")),
    										 	selectInput("viz","",
    										 							choices = c("Hexagon","3D Choropleth","Scatterplot","Proportional Symbol"),
    										 							selected = "Hexagon")


    										 )

    						),



    						tabPanel("Plot",

    										 selectInput(inputId = "select_city", label = "Select Neighbourhood Group",
    										 						choices = unique(df$neighbourhood_group),
    										 						selected = "Manhattan",
    										 						multiple = F),
    										 checkboxGroupInput(inputId = "room_types",
    										 									 label = 'Room Type:', choices = unique(df$room_type),
    										 									 selected = "Shared room",
    										 									 inline = T),



    										 plotlyOutput("dumbbel", height = "1000px"),



    						),


    						tabPanel("Dataset",

    										 h2(" AIRBNB New York CitY Dataset"),

    										 br(),

    										 downloadButton(outputId = "download", label = " Download Data"),

    										 br(),

    										 DT::dataTableOutput("data_table"),

    										 h4("Source of this data can be found ",HTML('<a href="http://insideairbnb.com/get-the-data.html"> HERE! </a>'))
    										 ),

    						tabPanel("About",

    										 mainPanel(h1(HTML('<img src = "https://media-exp3.licdn.com/dms/image/C5103AQGjTuoEXrfqDw/profile-displayphoto-shrink_800_800/0/1536674674811?e=1630540800&v=beta&t=4vtEHLbB3nq_y9H-aRTrkn3p5c-nuj8W5jblHwIl774" width=350 height=350')),

    										 					h4( "Mahardi Setyoso Pratomo"),
    										 					h4( "MapOps Associate at GRAB and parttime Geospatial Data Analyst"),
    										 					h4(HTML('<img src = "https://www.freepnglogos.com/uploads/linkedin-blue-style-logo-png-0.png" width=40 height=40')),(HTML('<a href="https://www.linkedin.com/in/mahardi-setyoso-pratomo-5ab97432/"> Linkedin </a>')),
    										 					h4(HTML('<img src = "https://image.flaticon.com/icons/png/512/25/25231.png" width=30 height=30')),(HTML('<a href="https://github.com/mahardisetyoso"> Github </a>')),
    										 					h4(HTML('<img src = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Gmail_icon_%282020%29.svg/512px-Gmail_icon_%282020%29.svg.png" width=30 height=20')),HTML("mahardisetyoso@gmail.com"),
    										 					h4(HTML('<img src = "https://iconape.com/wp-content/files/ty/64755/svg/grab-2.svg" width=30 height=30')),HTML("mahardi.pratomo@grabtaxi.com"),
    										 					h4(HTML('<img src = "https://cpsievert.me/images/thumbs/shiny.png" width=230 height=90')),
    										 					(HTML('<img src = "https://i1.wp.com/blog.datascienceheroes.com/content/images/2019/12/tidyverse.png?w=578&ssl=1" width=200 height=100'))





    										 					)

    										 )




    )


)
