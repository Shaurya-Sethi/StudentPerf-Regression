library(data.table)
library(ggplot2)
library(plotly)
library(dplyr)
library(ggthemes)
library(corrplot)
#Dataset from UCI Student+Performance
#Data already cleaned

dt <- fread("student-mat.csv")

#Checking the numeric columns in data table
num.cols <- sapply(dt, is.numeric)
#Making a data table of correlations between numeric features
cor.data <- cor(dt[,..num.cols])

#EDA 
#Plotting this corr data 
pl <- corrplot(cor.data,method = "color")
print(pl)
#checking the strong correlations between features 

#Have to predict G3, so visualising it
print(ggplot(dt , aes(x = G3)) + geom_histogram(bins = 20, alpha = 0.5, fill = 'green'))
#lot's of students failed/did'nt show up (0 G3 value)
#Also, a lot of students have a score of near 10 => Grading was curved?

library(caTools)

#training and testing

set.seed(101)

sample <- sample.split(dt$G3, SplitRatio = 0.7) #Can split any column (G3 not necessary)
#randomly creates a new column with boolean values T and F
#can use this to split data into training and test data

train <- subset(dt, sample == T)
test <- subset(dt, sample == F)

#Modelling using Linear Regression

model <- lm(G3 ~., data = train) #Builds and trains model
print(summary(model)) #interpret model

#Check p-value : lower implies a higher level of signifance => feature is highly associated with response(G3)
#Residuals : Error -> actual data point and predicted regression model result
#R square value signifies goodness of fit -> higher better (max 1)

res <- residuals(model)
res <- as.data.frame(res)
print(ggplot(res,aes(res))+geom_histogram(fill = 'green', alpha = 0.5)) #For most models, residuals should be normally distributed -> checking

# 4 advanced plots for residuals
print(plot(model))

#Predicting new values
G3.predictions <- predict(model,test)
results <- cbind(G3.predictions,test$G3)
colnames(results) <- c('predicted','actual')
results <- as.data.frame(results)

print(min(results))

#As seen before from the plot of residuals, there were negative values for scores which isn't possible because zero is lowest
#this can be confirmed from the results table as well

#To handle the same :

to_zero <- function(x){
  ifelse(x<0,return(0),return(x))
}

results$predicted <- sapply(results$predicted,to_zero)

library(knitr)
library(kableExtra)


results.kbl <- kable(results , caption = "Actual vs Predicted values") %>%
  kable_styling(bootstrap_options = c("striped", "hover"))

print(results.kbl)

#Finding Rsquare value
MSE <- mean( (results$actual - results$predicted)^2 )
cat(sprintf("The mean squared error is: %.7f",MSE),"\n")
RMSE <- MSE^0.5
cat(sprintf("The root mean squared error is: %.7f",RMSE),"\n")
SSE <- sum( (results$predicted - results$actual)^2 )
SST <- sum( (mean(dt$G3) - results$actual)^2 )

Rsquare <- 1 - SSE/SST
cat(sprintf("R\u00B2: %.7f",Rsquare),"\n")

#######################

#Comparing model performance: 
#Looking at p-values, identified most significant features 
#Using only those to model 

model_full <- lm(G3~.,data = train)
#Manually doing feature selection (Not always a good idea to remove insignificants - only for testing purposes)
model_reduced <- lm(G3 ~ absences + G2 + age + famrel + G1, data = train)
print(summary(model_reduced))

#compare models
anova_results <- anova(model_full,model_reduced)
anova_table <- as.data.frame(anova_results)
anova.kbl <- kable(anova_table, caption = "ANOVA Results")
print(anova.kbl)

#Conclusion :
cat("Since the p-value is > 0.05,
it suggests that adding additional predictors does not improve model significantly,
thus, it can be concluded that the reduced model is sufficiently accurate and can be prefered for simplicity.")

#A visualisation to compare the two models' predictions vs the actual values

pldf <- data.frame(
  predicted_full = predict(model_full, test),
  predicted_red = predict(model_reduced, test),
  actual = test$G3
)


plotting <- ggplot(pldf) +
  geom_point(aes(x = actual , y = predicted_full), color = "blue", size = 3, alpha = 0.7) +
  geom_point(aes(x = actual , y = predicted_red), color = "red", size = 3, alpha = 0.7) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black", size = 1) +
  labs(
    title = "Actual vs Predicted values for Full and Reduced Models",
    x = "Actual values (G3)",
    y = "Predicted values (G3)"
  ) +
  theme_minimal()

print(ggplotly(plotting))


##########################

#Lastly, can perform a combination of forward and backward feature selection while building model
#Step wise regression :

# Perform stepwise feature selection using the training dataset
model_stepwise <- step(lm(G3 ~ ., data = train), direction = "both", trace = 0)

# Display the summary of the stepwise-selected model
cat("\nStepwise Feature Selection Model Summary:\n")
print(summary(model_stepwise))

# Predict using the stepwise model
stepwise_predictions <- predict(model_stepwise, test)

# Add the stepwise predictions to the comparison data frame
pldf$predicted_stepwise <- stepwise_predictions

# Visualize the predictions of all three models
plotting <- ggplot(pldf) +
  geom_point(aes(x = actual, y = predicted_full), color = "blue", size = 3, alpha = 0.7) +
  geom_point(aes(x = actual, y = predicted_red), color = "red", size = 3, alpha = 0.7) +
  geom_point(aes(x = actual, y = predicted_stepwise), color = "green", size = 3, alpha = 0.7) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black", size = 1) +
  labs(
    title = "Actual vs Predicted values for Full, Reduced, and Stepwise Models",
    x = "Actual values (G3)",
    y = "Predicted values (G3)"
  ) +
  theme_minimal()

print(ggplotly(plotting))








