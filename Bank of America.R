# Load libraries
library(cluster)
library(mclust)
library(poLCA)

# Load and explore the data
boa_data <- read.csv("~/Desktop/IIT/Marketing Research & Engineering/Project/BOA.csv")

# Data exploration
dim(boa_data)  # Dimensions of the dataset
str(boa_data)  # Structure of the dataset
summary(boa_data)  # Summary statistics

boa.summ <- function(data, groups) {
  aggregate(data, list(groups), function(x) mean(as.numeric(x)))  
}


# Visualize PURCHASES
hist(boa_data$PURCHASES, breaks = 30, col = "purple", main = "Histogram of PURCHASES", 
     xlab = "PURCHASES", ylab = "Frequency")

# Preprocess the data: Remove CUST_ID column
boa_data <- boa_data[, -2]

# ----------------- Hierarchical Clustering -----------------

# Calculate distance matrix and apply hierarchical clustering
boa_dist <- daisy(boa_data)
boa_hc <- hclust(boa_dist, method = "complete")

# Plot dendrogram
plot(boa_hc, main = "Dendrogram of Complete Linkage", xlab = "Observations", ylab = "Height")
rect.hclust(boa_hc, k = 4, border = "red")  # Visualize 4 clusters

# Assign clusters
hc_clusters <- cutree(boa_hc, k = 4)
boa_data$HC_Cluster <- as.factor(hc_clusters)

# Summarize the clusters
aggregate(. ~ HC_Cluster, data = boa_data, mean)

# ----------------- K-Means Clustering -----------------

# Prepare data for k-means: scale numeric data
boa_scaled <- sapply(boa_data,is.numeric)
boa_scaled2<-boa_data
boa_scaled2[,boa_scaled]<-scale(boa_data[,boa_scaled])


# Apply k-means clustering
set.seed(1234)
kmeans_model <- kmeans(boa_scaled2, centers = 4)
boa_data$KMeans_Cluster <- as.factor(kmeans_model$cluster)

# Summarize the clusters
aggregate(. ~ KMeans_Cluster, data = boa_data, mean)

# ----------------- Model-Based Clustering -----------------

# Apply Mclust
mclust_model <- Mclust(boa_scaled2)
summary(mclust_model)

# Assign clusters
boa_data$MClust_Cluster <- as.factor(mclust_model$classification)

# Summarize the clusters
aggregate(. ~ MClust_Cluster, data = boa_data, mean)


# ----------------- Visualization -----------------

# Cluster plots for KMeans and MClust
clusplot(boa_scaled2, kmeans_model$cluster, color = TRUE, shade = TRUE, lines = 0, main = "K-Means Cluster Plot")
clusplot(boa_scaled2, mclust_model$classification, color = TRUE, shade = TRUE, lines = 0, main = "Model-Based Cluster Plot")

# Comparison of clustering solutions
adjustedRandIndex(kmeans_model$cluster, mclust_model$classification)

