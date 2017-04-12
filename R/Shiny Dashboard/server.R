  
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)
library(dplyr)
library(lubridate)
library(DT)
library(googleVis)
library(tidyr)

#Data Set
sdata <- read.csv("sdata.csv")

shinyServer(function(input, output) {
  
  output$totysales <- renderValueBox({
    totysale <- dplyr::summarise(group_by(
      select(sdata,Order_Date,Sales),
      Year = year(as.Date(Order_Date))),
      sales=round(sum(Sales)))
    valueBox(
      paste0(round(totysale$sales[4]/1000000,digits=2)," M"),tags$b("SALES"),icon=icon("usd"),color = "blue",width = 3
    )
  })
  
  output$totyprofit <- renderValueBox({
    totyprof <- dplyr::summarise(group_by(
      select(sdata,Order_Date,Profit),
      Year = year(as.Date(Order_Date))),
      profit=round(sum(Profit)))
    valueBox(
      paste0(round(totyprof$profit[4]/1000, digits = 2)," K"),tags$b("PROFIT"),icon=icon("usd"),color = "orange",width = 3
    )
  })
  
  output$mostship <- renderValueBox({
    mship <- dplyr::summarise(group_by(
      select(sdata,Ship_Mode,Order_Date),Year=year(as.Date(Order_Date)),
      Ship_Mode),count=n())
    valueBox(
      paste0(mship$Ship_Mode[12]),tags$b("Most Ship Mode"),icon=icon("gift"),color = "green",width = 3
    )
  })
  
  output$bestcat <- renderValueBox({
    mcat <- dplyr::summarise(group_by(
      select(sdata,Product_Category,Order_Date),Year=year(as.Date(Order_Date)),
      Product_Category),count=n())
    valueBox(
      paste0(mcat$Product_Category[11]),tags$b("Best Sold Category"),icon=icon("tags"),color = "purple",width = 3
    )
  })
  
  output$ymsalgraph <- renderGvis({
    ysales <- summarise(group_by(
      select(sdata,Order_Date,Sales),
      Year =year(as.Date(Order_Date)),Month=month(as.Date(Order_Date),label = TRUE)),sales=round(sum(Sales)))
    ysales <- ysales[37:48,]
    ysales$Year <- NULL
    ysalechart <- gvisColumnChart(ysales,xvar="Month",yvar="sales",options = list(width="675px",height="400px",
                                                                        colors="['purple']"))
    return(ysalechart)
  }) 
  
  output$ympgraph <- renderGvis({
    yprofit <- summarise(group_by(
      select(sdata,Order_Date,Profit),
      Year =year(as.Date(Order_Date)),Month=month(as.Date(Order_Date),label = TRUE)),profit=round(sum(Profit)))
    yprofit <- yprofit[37:48,]
    yprofit$Year <- NULL
    yprofitchart <- gvisColumnChart(yprofit,xvar="Month",yvar="profit",options = list(width="675px",height="400px",
                                                                                  colors="['green']"))
    return(yprofitchart)
  }) 
  
  output$ypwisegraph <- renderGvis({
    provincesale <- summarise(group_by(
         select(sdata,Sales,Province,Order_Date),Year=year(as.Date(Order_Date)),
          Province),sales=round(sum(Sales)))
    provincesale <- provincesale[40:52,]
    provincesale$Year <- NULL
    ppie <- gvisPieChart(provincesale,"Province","sales",options = list(width="470px",height="400px"))
    return(ppie)
  }) 
  
 
  output$dataexptable <- renderDataTable({
    dataxp <- sdata[,c("Order_ID","Order_Date","Sales","Product_Category","Province","Ship_Mode","Ship_Date")]
    dataxp
  })
  
  output$provinceanalysis <- renderGvis({
    provincesale <- summarise(group_by(
      select(sdata,Sales,Province),
      Province),sales=round(sum(Sales)))
    geostate <- gvisGeoChart(provincesale,"Province","sales",options=list(region="CA",displayMode="regions",resolution="provinces",colors="['olive','purple','orange']"))
    return(geostate)
    
  })
  
  output$yearlysalgraph <- renderGvis({
    ysales <- summarise(group_by(
      select(sdata,Order_Date,Sales),
      Year =year(as.Date(Order_Date))),sales=round(sum(Sales)))
    ysalechart <- gvisColumnChart(ysales,xvar = "Year",yvar = "sales",options = list(hAxes="[{viewWindow:{min:2008,max:2013},format:'####'}]",colors="['green']"))
    return(ysalechart)
  }) 
  
  output$provincewisegraph <- renderGvis({
    provincesale <- summarise(group_by(
      select(sdata,Sales,Province),
      Province),sales=round(sum(Sales)))
    ppie <- gvisPieChart(provincesale,"Province","sales",options = list(width="500px",height="350px"))
    return(ppie)
  }) 
  
  output$catwisegraph <- renderGvis({
    mcat <- summarise(group_by(
       select(sdata,Product_Category,Sales,Order_Date),Year=year(as.Date(Order_Date)),
       Product_Category),sales=round(sum(Sales)))
    mcat <- spread(mcat,key=Product_Category,value = sales)
    chart <- gvisColumnChart(mcat,"Year",c("Furniture","Office Supplies","Technology"),options = list(hAxes="[{viewWindow:{min:2008,max:2013},format:'####'}]"))
    return(chart)
  })
  
  
  
})
