# The UI is the result of calling the `fluidPage()` layout function
my_ui <- fluidPage(
  theme = "mrkov.css",
  # A static content element: a 2nd level header that displays text
  titlePanel("mRkov: Simulate and replicate Twitter data"),

  sidebarLayout(position = "left",
                sidebarPanel("Options",
                             textInput(inputId = "username", label = "Insert Twitter handle (@)"),

                             # a button to activate a twitter search
                             actionButton(inputId = "search", label = "Search Twitter!"),

                             # An output element: a text output (for the `message` key)
                             textOutput(outputId = "message"),
                             textOutput(outputId = "tweets_found"),

                             # checkbox to include retweets
                             checkboxInput(inputId = "includeRts",
                                           label = "Include Retweets"),
                             checkboxInput(inputId = "includeReplies",
                                           label = "Include Replies"),
                             numericInput(inputId = "ngram",
                                          label = "N-gram size",  value = 1),
                             # Paragraph detailing issues
                             p("Experiencing issues? Check the \"Test Locally\" tab")

                             ),
                mainPanel(
                  tabsetPanel(type = "tabs",
                              # Sentence Generation
                              tabPanel("Markov Chain",
                                       h2("Sentence Options"),
                                       fluidRow(
                                          column(5,
                                            numericInput(inputId = "num_sentences", label = "Number of sentences",  value = 1)
                                            ),
                                          column(5,
                                            textInput(inputId = "prompt", label = "Sentence Prompt")
                                            )
                                       ),
                                       actionButton(inputId = "make_sentence", label = "Make a Sentence!"),
                                       # An output element: a text output (for the `message` key)
                                       htmlOutput(outputId = "sentence"),
                                       ),
                              # Word Cloud and word cloud settings
                              tabPanel("Word Cloud",
                                       # Outputting a wordcloud
                                       plotOutput("plot", width = "2%"), # edited
                                       h2("Wordcloud filter"),
                                       fluidRow(
                                         column(5,
                                                textInput(inputId = "stop_word", label = NULL)
                                         ),
                                         column(6,
                                                actionButton(inputId = "add_stop_word", label = "Add Word"),
                                         ),
                                         column(9,
                                                numericInput(inputId = "num_words", label = "Wordcloud size", value = 20))
                                         ),
                                       DT::dataTableOutput("stopwords"),
                                       actionButton(inputId = "deleteRows", label = "Delete Rows")),
                              tabPanel("Test Locally",
                                       h2("Right now, we are experiencing extremely high traffic
                                          that exceeds the capacities of our server!"),
                                       p("We are working on a fix for the issue. In the meantime,
                                         you may experince issues."),
                                       p("Alternatively, you can try the tool on your own computer
                                         if you have the software R installed!"),
                                       h3("Step 1:"),
                                       code('remotes::install_github("serrat839/mRkov")'),
                                       h3("Step 2:"),
                                       code('shiny::runGitHub("mRkov_shiny", username="serrat839")')
                              )

                  ),


                  )
                )


)
