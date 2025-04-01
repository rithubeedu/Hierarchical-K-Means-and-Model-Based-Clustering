# 💳 Bank of America Credit Card Customer Segmentation

This project uses unsupervised learning techniques to segment ~9,000 active credit card users of Bank of America. The goal is to derive meaningful customer clusters for targeted marketing strategies based on behavioral and transactional attributes.

---

## 📂 Dataset Overview

**File:** `BOA.csv`  
Contains customer credit card usage over 6 months with the following features:
- `BALANCE`: Remaining amount in the account
- `PURCHASES`: Total purchase amount
- `CASH_ADVANCE`, `CREDIT_LIMIT`, `PAYMENTS`, `MINIMUM_PAYMENTS`
- Frequency metrics: `PURCHASES_FREQUENCY`, `ONEOFFPURCHASESFREQUENCY`, etc.
- `TENURE`: Duration of customer relationship

---

## 🔍 Project Goals

As Chief Marketing Officer, you are tasked with:
- Discovering behavioral clusters within credit card users
- Using clustering insights to design tailored marketing strategies
- Comparing and evaluating multiple clustering algorithms

---

## ⚙️ Methodology

### 1. 🧹 Data Preprocessing
- Removed non-informative `CUST_ID` column
- Scaled numerical variables for fair clustering
- Visualized `PURCHASES` distribution using histogram

### 2. 🌳 Hierarchical Clustering
- Method: **Complete Linkage** using `hclust()`
- Optimal clusters: **k = 4**
- Dendrogram plotted with cluster highlights

### 3. 📦 K-Means Clustering
- Used standardized data with `kmeans()` and `k = 4`
- Analyzed and summarized average feature values per cluster

### 4. 📊 Model-Based Clustering
- Used `Mclust()` for statistical modeling
- Automatically identified optimal clustering structure
- Compared performance with K-Means via **Adjusted Rand Index**

---

## 📊 Results Summary

| Clustering Method | Cluster Count | Insights |
|-------------------|----------------|----------|
| Hierarchical      | 4              | Clear segmentation based on balance and purchase patterns |
| K-Means           | 4              | High-value vs low-activity users identified |
| Model-Based       | Auto-detected  | Best model fit, highest statistical validity |

---

## 📈 Visualizations
- Histogram of purchases
- Dendrogram of hierarchical clustering
- 2D cluster plots using `clusplot()` for K-Means and Mclust

---

## 📦 Libraries Used
```r
library(cluster)
library(mclust)
library(poLCA)
