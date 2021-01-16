df <- read.csv("/Users/aaske/Documents/365DataScience/365datascience-master/14. Intro to R/9. Visualizing data/titanic.csv", stringsAsFactors = FALSE)
df <- as.tibble(df)

df$Survived <- as.factor(df$Survived)
df$Pclass <- as.factor(df$Pclass)
df$Sex <- as.factor(df$Sex)
df$Embarked <- as.factor(df$Embarked)
df

// Bar chart
my.box <- ggplot(df, aes(x = Survived, y = Age))
my.box + geom_boxplot() +
  labs(title = "Survival Rate on the Titanic Based on Age") +
  theme_light()


// Other functionallites of boxplot
my.box <- ggplot(df, aes(x = Survived, y = Age))
my.box + geom_boxplot(outlier.color = "red", outlier.shape = 4) + 
  geom_jitter(width = 0.2, aes(color=Sex)) +
  labs(title = "Survival Rate on the Titanic Based on Age") +
  theme_light()
