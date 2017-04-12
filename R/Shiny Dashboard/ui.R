
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)
library(dplyr)
library(lubridate)
library(googleVis)
library(DT)

shinyUI(dashboardPage(skin = "black",
  
    dashboardHeader(title = "Retail Analytics"),
    dashboardSidebar(
      sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard",icon = icon("dashboard",lib="glyphicon")),
      menuItem("Trends", tabName = "datatrend",icon = icon("signal",lib="glyphicon")),
      menuItem("Data Explorer", tabName = "dataexplorer",icon = icon("th",lib="glyphicon")),
      menuItem("About", tabName = "about", icon = icon("bell",lib = "glyphicon"))
    )),
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "dashboard",
                fluidPage(
                  title = "Dashboard",
                fluidRow(column(width=12,
                  valueBoxOutput("totysales",width=3),
                  valueBoxOutput("totyprofit",width=3),
                  valueBoxOutput("mostship",width = 3),
                  valueBoxOutput("bestcat",width = 3)
                  
                )),
                fluidRow(
                  column(width =12,
                         box(
                           tabsetPanel(
                             tabPanel("Sales", htmlOutput("ymsalgraph")),
                             tabPanel("Profit", htmlOutput("ympgraph"))
                           ),
                           title = "Current Year Analysis",
                           solidHeader = TRUE,
                           width = 7
                           
                         ),
                         box(
                           title = "Current Province Wise Sales Analysis",
                           width = 5,
                           height = "500px",
                           solidHeader = TRUE,
                           collapsible = FALSE,
                           htmlOutput("ypwisegraph")
                         )
                  )
                ),
               fluidRow(column(width=12,
                                box(
                                  title = "Retail Analysis",
                                  width = 12,
                                  background = "orange",
                                  solidHeader = TRUE,
                                  status = "warning",
                                  "The dashboard provides a real time insights of the retail data in current year! In this case, the current year is 2012.
                                  "
                                )
                          ))
                )),
        tabItem(tabName = "dataexplorer",
                fluidPage(
                  titlePanel("Data Table"),
                  
                  # Create a new Row in the UI for selectInputs
                  fluidRow(
                    DT::dataTableOutput("dataexptable")
                  ))
                ),
       
        tabItem(tabName = "datatrend",
                fluidPage(
                  fluidRow(
                    column(width =12,
                           box(
                             title = "Province Wise Sales Analysis",
                             width = 6,
                             solidHeader = TRUE,
                             collapsible = FALSE,
                             htmlOutput("provincewisegraph")
                           ),
                           box(
                             title = "location Trends",
                             width = 6,
                             htmlOutput("provinceanalysis")
                           )
                    )
                  ),
                  fluidRow(
                    column(width=12,
                           box(
                             title = "Cat Vs Sales Trend",
                             solidHeader = TRUE,
                             width=8,
                             htmlOutput("catwisegraph")
                           ),
                           box(
                             title = "Yearly Sales Analysis",
                             solidHeader = TRUE,
                             width = 4,
                             htmlOutput("yearlysalgraph")
                           )
                    )
                  )
                )
                ),
        tabItem(tabName = "about",
                fluidPage(
                  fluidRow(
                    box(
                      title = "About",
                      solidHeader = TRUE,
                      status = "warning",
                      width = 12,
                      p("This Project provides Data Insights, Analysis & Predictive modeling to forecast the sales data using machine learning"),
                      p("Dataset description: The data set contains four years of retail orders (2009-2012)"),
                      p("About the project"),
                      tags$ul(
                        tags$li("Dashboard - Provides real time data insights of current year (2012 Assumed)"),
                        tags$li("Trends - Data analysis on available historical data (2009-2012)"),
                        tags$li("Data Explorer - An overview of Dataset")
                      ),
                      p(" The goal of this project is to demonstrate the feasability of R language to perform statistical analysis & predictive analytics to help in strategizing and streamlining the business model"),
                      p(" No matter what the industry, Prediction help companies use their data to increase revenue and take strategical decisions. We can accomplish this by using machine learning and statistical modeling on existing data to provide meaningful predictions!"),
                      p(" R Rocks!! "),
                      h1("@# - Ashok Kandipati")
                    )
                  )
                ))
      )
    )
    
  )
)
