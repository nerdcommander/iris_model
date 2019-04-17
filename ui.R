dashboardPage(
  dashboardHeader(title="Iris Dash"),
  dashboardSidebar(H1="Input values to test",
    numericInput('Sepal.Length', 'Sepal Length', 5.0,
                 min = 0),
    numericInput('Sepal.Width', 'Sepal Width', 3.0,
                 min = 0),
    numericInput('Petal.Length', 'Petal Length', 4.0,
                 min = 0),
    numericInput('Petal.Width', 'Petal Width', 1.0,
                 min = 0)
  ),
  dashboardBody(
    fluidRow(
        valueBoxOutput("new_spec_pred"),
        valueBoxOutput("top_prob")
    ),
    fluidRow(
        box(DT::dataTableOutput("new_pred"), width=6,  
            title="predicted probability for your input values"),
        box(plotOutput("scatter"), width=6, 
            title="your input values are plotted as the red star")
    ),
    fluidRow(
      box(plotOutput("SLdens"), width=6, title="Sepal Length density plot"),
      box(plotOutput("SWdens"), width=6, title="Sepal Width density plot")
    ),
    fluidRow(
      box(plotOutput("PLdens"), width=6, title="Petal Length density plot"),
      box(plotOutput("PWdens"), width=6, title="Petal Width density plot")
    ),
    fluidRow(
      box(DT::dataTableOutput("table"), width = 12, title="complete model output")
    )

  )
)


