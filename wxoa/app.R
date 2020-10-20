library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)

data = rio::import("../data/getuserread.csv")
data$ref_date = as.Date(data$ref_date)
data = tidyr::pivot_longer(
    data,
    -c(ref_date, user_source),
    names_to = "type",
    values_to = "num"
    ) %>%
    mutate(type2 = stringr::str_extract(type, "user|count"))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            dateRangeInput(
                inputId = "dates",
                label = "选择日期",
                start = min(data$ref_date),
                end = max(data$ref_date),
                min = min(data$ref_date),
                max = max(data$ref_date)

            ),
            checkboxGroupInput(
                inputId = "types",
                label = "选择指标",
                choices = c(
                    "图文页" = "int_page_read",
                    "原文页" = "ori_page_read",
                    "分享" =  "share",
                    "收藏" = "add_to_fav"
                )
            ),
            checkboxGroupInput(
                inputId = "userORcount",
                label = "人次或者次数",
                choices = c(
                    "人次" = "user",
                    "次数" = "count"
                )
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("plotly")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    filter_data = reactive({
        daterange = input$dates
        types = input$types
        userorcount = input$userORcount

        data %>%
            # filter(ref_date >= daterange[1] & daterange <= daterange[2]) %>%
            filter(type %in% types) %>%
            filter(type2 %in% userorcount)

    })

    output$plotly <- renderPlotly({

        p = ggplot(filter_data()) +
            geom_col(aes(ref_date, num, fill = as.factor(user_source)))

        p = ggplotly(p)

        print(p)

    })
}

# Run the application
shinyApp(ui = ui, server = server)
