#* @get /setosa
function(){
  sLength <- mean(iris$Sepal.Length[iris$Species=="setosa"])
  sWidth <- mean(iris$Sepal.Width[iris$Species=="setosa"])
  pLength <- mean(iris$Petal.Length[iris$Species=="setosa"])
  pWidth <- mean(iris$Petal.Width[iris$Species=="setosa"])
  value <- c(sLength,sWidth,pLength,pWidth)
}

#* @get /versicolor
function(){
  sLength <- mean(iris$Sepal.Length[iris$Species=="versicolor"])
  sWidth <- mean(iris$Sepal.Width[iris$Species=="versicolor"])
  pLength <- mean(iris$Petal.Length[iris$Species=="versicolor"])
  pWidth <- mean(iris$Petal.Width[iris$Species=="versicolor"])
  value <- c(sLength,sWidth,pLength,pWidth)
}

#* @get /virginica
function(){
  sLength <- mean(iris$Sepal.Length[iris$Species=="virginica"])
  sWidth <- mean(iris$Sepal.Width[iris$Species=="virginica"])
  pLength <- mean(iris$Petal.Length[iris$Species=="virginica"])
  pWidth <- mean(iris$Petal.Width[iris$Species=="virginica"])
  value <- c(sLength,sWidth,pLength,pWidth)
}

