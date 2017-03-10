# Michael A. Alcorn (airalcorn2@gmail.com)
# Data from: http://www.seanlahman.com/baseball-archive/statistics/.

library(FNN)

# Pitching.
data <- read.csv("Pitching.csv")
keeps <- c("playerID", "W", "L", "G", "GS", "CG", "SHO", "SV", "IPouts", "H", "ER", "SO", "BAOpp", "ERA", "IBB", "WP", "HBP", "BK", "BFP", "GF", "R", "SH", "SF", "GIDP")
only.2015 <- data[data$yearID == 2015, keeps]
only.2015[is.na(only.2015)] <- 0

feats <- c("W", "L", "G", "GS", "CG", "SHO", "SV", "IPouts", "H", "ER", "SO", "BAOpp", "ERA", "IBB", "WP", "HBP", "BK", "BFP", "GF", "R", "SH", "SF", "GIDP")
train <- only.2015[, feats]
train <- apply(train, 2, function(x) x / max(x))
test <- only.2015[only.2015$playerID == "kershcl01", feats]

k <- knn(train, test, only.2015$playerID, k = 11)
indices <- attr(k, "nn.index")
only.2015[indices, "playerID"]

# Batting.
data <- read.csv("Batting.csv")
keeps <- c("playerID", "AB", "R", "H", "X2B", "X3B", "HR", "RBI", "SB", "CS", "BB", "SO", "IBB", "HBP", "SH", "SF", "GIDP")
only.2015 <- data[data$yearID == 2015, keeps]
only.2015[is.na(only.2015)] <- 0

feats <- c("AB", "R", "H", "X2B", "X3B", "HR", "RBI", "SB", "CS", "BB", "SO", "IBB", "HBP", "SH", "SF", "GIDP")
train <- only.2015[, feats]
train <- apply(train, 2, function(x) x / max(x))
test <- train[only.2015$playerID == "gordode01", ]

k <- knn(train, test, only.2015$playerID, k = 11)
indices <- attr(k, "nn.index")
only.2015[indices, "playerID"]
