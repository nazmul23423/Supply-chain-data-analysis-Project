# 📦 Supply Chain Data Analysis

## 🔧 Tech Stack

- **Tool**         — **Purpose**                          

- **Python (pandas, SQLAlchemy)**   — Data loading & cleaning
- **Python (matplotlib.pyplot)**   — Python visualizations  
- **PostgreSQL** — Relational database & SQL queries 
- **Jupyter Notebook**  — EDA & analysis workflow     
- **Power BI** — Interactive visualizations        

---

## 📌 Project Overview

This project performs a complete end-to-end data analysis of the **DataCo Global Supply Chain Dataset** using Python, PostgreSQL, and Power BI. It answers 20 key business questions — such as which market generates the most profit, which shipping mode has the highest late delivery rate, and which customer segment drives the most revenue.

The analysis covers **180,519 orders** across **5 global markets** and **53 data columns**, combining SQL queries, Python visualizations, and an interactive Power BI dashboard into a single portfolio-ready project.

---

## 📊 Dataset Overview

- **Property**         — **Details**
- 
- **Dataset Name**   —  DataCo Supply Chain Dataset 
- **Source** —  [Kaggle - DataCo Smart Supply Chain](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis) 
- **Total Records**   —  ~180,519 rows 
- **Total Columns**   —  53 columns 
- **Date Range**  —  Multi-year global supply chain orders 
- **Markets Covered**   —  Europe, LATAM, Pacific Asia, USCA, Africa 

### Key Columns Used
- Order Id, Order Date, Shipping Date, Delivery Status
- Customer Segment, Market, Order Region, Department Name, Category Name
- Sales, Order Profit Per Order, Order Item Discount Rate, Order Item Quantity
- Shipping Mode, Days for shipping, Days for shipment, Product Name

---

## 🎯 Business Questions Answered (20 Analyses)

### 🟢 Basic Analysis (Q1–Q8)
| # | Question | Key Finding |
|---|---|---|
| Q1 | Total unique orders in the dataset? | Dataset contains 76,101 unique orders |
| Q2 | Orders by Shipping Mode? | Standard Class is the most frequently used shipping mode |
| Q3 | Which Customer Segment generates highest Sales? | The Consumer segment generates the most revenue |
| Q4 | Total count of late deliveries? | Approximately 54.83% of all orders are delivered late |
| Q5 | Top 5 best-selling products by quantity? | Perfect Fitness, Nike, and Field & Stream are the top sellers |
| Q6 | Total profit per Market? | Europe generates the highest total profit |
| Q7 | Orders by Order Status with percentage? | Closed orders account for the largest share (~45%) |
| Q8 | Average profit per Department (Profit > 0)? | The Fan Shop department is the most profitable |

### 🟡 Intermediate Analysis (Q9–Q14)
| # | Question | Key Finding |
|---|---|---|
| Q9 | Which Order Region has the highest Late Delivery Rate? | Latin America has the highest late delivery rate |
| Q10 | Total Sales per month? | Sales remain relatively stable throughout the year |
| Q11 | Profit by Customer Segment & Shipping Mode? | Consumer + Standard Class yields the highest profit |
| Q12 | Products with net loss (Profit < 0)? | Several products consistently generate losses |
| Q13 | Average shipping delay per Shipping Mode? | Same Day shipping has the lowest average delay |
| Q14 | Discount rate vs Sales and Profit per Category? | Higher discount rates lead to lower profit margins |

### 🔴 Advanced Analysis (Q15–Q20)
| # | Question | Key Finding |
|---|---|---|
| Q15 | Top-selling product in each Order Region? (Window Function) | Each region has a different top-performing product |
| Q16 | Month-over-Month Sales Growth? (LAG Function) | Sales show sudden spikes and drops in certain months |
| Q17 | Cumulative Sales per Market over time? | Europe gradually overtakes LATAM in cumulative sales |
| Q18 | Top 10 customers by total revenue? (Customer LTV) | The top 10 customers contribute a significant share of total revenue |
| Q19 | Late delivery orders — which Shipping Mode lost most profit? | Standard Class accounts for the highest profit loss from late deliveries |
| Q20 | Department's percentage contribution to total Sales? | Fan Shop and Apparel are the largest contributors to total sales |

---

## 🗂️ Project Structure

```
supply-chain-data-analysis/
│
├── 📄 README.md                                        ← You are here
│
├── 📁 sql/
│   ├── Supply_Analysis.sql                             ← All 20 SQL queries (Basic → Advanced)
│   └── create_table.sql                                ← Manual table creation script
│
├── 📁 notebooks/
│   └── Supply_chain.ipynb                              ← Full Jupyter Notebook (EDA + Visualizations)
│
├── 📁 visualizations/
│   └── [auto-generated PNG charts]                     ← Charts saved from the notebook
│
├── 📁 dashboard/
│   └── Supply_chain_Data_Analysis_dashboard.pbix       ← Power BI Dashboard file
│
├── 📁 data/
│   └── README.md                                       ← Dataset download instructions
│
├── connect_db.py                                       ← CSV to PostgreSQL data loader script
├── requirements.txt                                    ← Python dependencies
└── .gitignore                                          ← Git ignore rules
```

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| **Python 3.10+** | Data loading, cleaning, and visualization |
| **Pandas** | DataFrame operations and data wrangling |
| **Matplotlib / Seaborn** | Chart and graph generation |
| **SQLAlchemy** | Python to PostgreSQL database connection |
| **PostgreSQL 15** | SQL-based analysis and querying |
| **Jupyter Notebook** | Interactive data exploration environment |
| **Power BI** | Business Intelligence dashboard |

---

## ⚙️ Setup & Installation

### Prerequisites
- Python 3.10+
- PostgreSQL 15+
- Jupyter Notebook or JupyterLab
- Power BI Desktop (to open the .pbix dashboard file)

### Step 1 — Clone the Repository
```bash
git clone https://github.com/nazmul23423/supply-chain-data-analysis.git
cd supply-chain-data-analysis
```

### Step 2 — Install Python Dependencies
```bash
pip install -r requirements.txt
```

### Step 3 — Download the Dataset
Download `DataCoSupplyChainDataset.csv` from [Kaggle](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis) and place it inside the `data/` folder.

### Step 4 — Setup PostgreSQL Database
Open PostgreSQL and create a new database:
```sql
CREATE DATABASE Supply_chain_analysis;
```

### Step 5 — Load Data into PostgreSQL
Update your database credentials in `connect_db.py`, then run:
```bash
python connect_db.py
```

This will automatically clean the data and load it into your PostgreSQL database.

Alternatively, run the first few cells of the Jupyter Notebook manually:
```python
import pandas as pd
from sqlalchemy import create_engine

df = pd.read_csv("data/DataCoSupplyChainDataset.csv", encoding="latin1")
engine = create_engine("postgresql://postgres:YOUR_PASSWORD@localhost:5432/Supply_chain_analysis")
df.to_sql("supply_chain", con=engine, if_exists="replace", index=False)
print("Data loaded successfully!")
```

### Step 6 — Run the Jupyter Notebook
```bash
jupyter notebook notebooks/Supply_chain.ipynb
```

### Step 7 — Run SQL Queries
- <a href="https://github.com/nazmul23423/Supply-chain-data-analysis-Project/blob/master/Supply_Analysis.sql">Sql Query</a>

### Step 8 — Open the Power BI Dashboard
- <a href="https://github.com/nazmul23423/Supply-chain-data-analysis-Project/blob/master/Supply%20chain%20Data%20Analysis%20dashboard.pbix">Power bi visualization</a>


## 📈 Power BI Dashboard Highlights

| KPI Card | Value |
|---|---|
| 💰 Total Sales | **$36.78M** |
| 📦 Total Orders | **180,519** |
| 🏷️ Product Price | **$25.50M** |
| 📊 Total Quantity | **384K** |
| 🎁 Total Discount | **$2.72M** |

### Dashboard Visuals
- 📊 **Total Sales & Profit by Top 5 Products** — Bar chart
- 🍩 **Order Count by Delivery Status** — Donut chart (54.83% Late Delivery)
- 📉 **Total Sales by Market** — Line chart (Europe > LATAM > Pacific Asia > USCA > Africa)
- 🔵 **Total Sales by Customer Segment** — Pie chart (Consumer: 51.91%)
- 📅 **Monthly Sales & Profit Trend** — Combined bar and line chart
- 🚚 **Average Shipment Days by Delivery Status** — Visual comparison
- 🏬 **Discount by Department** — Horizontal bar chart (Fan Shop highest: 1.74M)
- 📦 **Order Count by Shipping Mode** — Column chart

---

## 🔍 Key Insights

**1. Late Delivery is a Critical Problem**
**54.83%** of all orders are delivered late, posing a significant risk to customer satisfaction and retention.

 **2. Consumer Segment Dominates**
- The Consumer segment accounts for **51.91%** of total Sales, making it the most important customer group to focus on.

 **3. Europe is the Top Market**
- Europe generates the highest Sales and Profit across all markets, while Africa contributes the least.

 **4. Fan Shop Department Leads**
- The Fan Shop department receives the highest total discount (1.74M) and is also the most profitable department overall.

 **5. Standard Class is Popular but Risky**
- Standard Class is the most widely used shipping mode, yet it accounts for the highest profit loss due to late deliveries.

 **6. High Discount Does Not Mean High Profit**
- The Q14 analysis reveals that higher discount rates are associated with lower profit margins — indicating a need to revisit the pricing and discount strategy.

---

## Dashboard

- <a href="https://github.com/nazmul23423/Supply-chain-data-analysis-Project/blob/master/Supply%20chain%20Analysis%20visualizations.png">Dashboard image</a>


## 🤝 Connect with Me

- GitHub: [ @nazmul23423](https://github.com/your-username)
- LinkedIn: [ md-nazmul-islam-8b5770388](https://linkedin.com/in/md-nazmul-islam-8b5770388)


---

