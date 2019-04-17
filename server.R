server <- function(input, output) { 
  
  DF <- reactive({
    pred_spec
  })
  
  PREDTAB <- reactive({
    values <- data.frame('Sepal.Length' = input$Sepal.Length, 
                         'Sepal.Width' = input$Sepal.Width, 
                         'Petal.Length' = input$Petal.Length, 
                         'Petal.Width' = input$Petal.Width)
    newx <- as.matrix(values)
    
    new_p <- round(predict(IrisClass, newx),7)
    
    new_df <- 
      data.frame('species' = c("setosa", "versicolor", "virginica"), probability=new_p)
    arrange(new_df, desc(probability))
  })
  
  PREDS <- reactive({
    values <- data.frame('Sepal.Length' = input$Sepal.Length, 
                         'Sepal.Width' = input$Sepal.Width, 
                         'Petal.Length' = input$Petal.Length, 
                         'Petal.Width' = input$Petal.Width)
    newx <- as.matrix(values)
    
    new_p <- predict(IrisClass, newx)
    
    iris_pspec(data.frame("setosa"=new_p[1], 
                          "versicolor"=new_p[2], 
                          "virginica"=new_p[3]))
  })

  TP <- reactive({
    values <- data.frame('Sepal.Length' = input$Sepal.Length, 
                         'Sepal.Width' = input$Sepal.Width, 
                         'Petal.Length' = input$Petal.Length, 
                         'Petal.Width' = input$Petal.Width)
    newx <- as.matrix(values)
    
    new_p <- round(max(predict(IrisClass, newx)),5)
  })
  
  output$new_pred <- DT::renderDataTable({
    PREDTAB()
  })
    
  output$table <- DT::renderDataTable({
    DF()
  })
  
  output$new_spec_pred <- renderValueBox({
    valueBox(
      #new_p2 <- predict(IrisClass, as.matrix(values)),
      PREDS(),
      "predicted species", color='green'
    )
  })
  
  output$top_prob <- renderValueBox({
    valueBox(
      TP(),
      "probability", color='green'
    )
  })
  
  output$scatter <- renderPlot({
    values <- data.frame('Sepal.Length' = input$Sepal.Length, 
                         'Sepal.Width' = input$Sepal.Width, 
                         'Petal.Length' = input$Petal.Length, 
                         'Petal.Width' = input$Petal.Width)
    # scatter plot
    ggplot(iris) + geom_point(aes(Sepal.Length, Sepal.Width, color=Species)) + 
      geom_point(data=values, aes(Sepal.Length, Sepal.Width), color='red', shape=8, size=5) + 
      theme_minimal() + scale_color_manual(values=c('#1b9e77','#d95f02','#7570b3'))
  })
  
  output$SLdens <- renderPlot({
    ggplot(iris) + geom_density(aes(Sepal.Length, fill=Species)) +
      geom_vline(xintercept = input$Sepal.Length) + 
      theme_minimal() + scale_color_manual(values=c('#1b9e77','#d95f02','#7570b3'))
  })
  
  output$SWdens <- renderPlot({
    ggplot(iris) + geom_density(aes(Sepal.Width, fill=Species)) +
      geom_vline(xintercept = input$Sepal.Width) + 
      theme_minimal() + scale_color_manual(values=c('#1b9e77','#d95f02','#7570b3'))
  })
  
  output$PLdens <- renderPlot({
    ggplot(iris) + geom_density(aes(Petal.Length, fill=Species)) +
      geom_vline(xintercept = input$Petal.Length) + 
      theme_minimal() + scale_color_manual(values=c('#1b9e77','#d95f02','#7570b3'))
    
  })
  
  output$PWdens <- renderPlot({
    ggplot(iris) + geom_density(aes(Petal.Width, fill=Species)) +
      geom_vline(xintercept = input$Petal.Width) + 
      theme_minimal() + scale_color_manual(values=c('#1b9e77','#d95f02','#7570b3'))
    
  })
}


