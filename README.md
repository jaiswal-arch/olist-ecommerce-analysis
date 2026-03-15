# **Olist E-Commerce Analytics**

###### SQL + Power BI Case Study







##### **Problem Statement**



As a data analyst brought in to evaluate business performance for a mid-size Brazilian e-commerce company, I analyzed two years of transactional data to answer three core questions:



* What is driving revenue performance and where is growth concentrated?
* Where are operational inefficiencies in the delivery pipeline?
* What does the customer base look like, and where is the retention opportunity?







##### **Dataset**



###### Source: \[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle



|Tables|Description|Rows|
|-|-|-|
|Orders|Order lifecycle and timestamps|99,441|
|Customers|Customer location and IDs|99,441|
|Order Items|Products per order|112,650|
|Order Payments|Payment values and methods|103,886|
|Products|Product metadata and category|32,951|
|Sellers|Seller IDs and location|3,095|
|Product Category|Portuguese to English translation|71|





###### Time period: October 2016 — August 2018







##### **Tools**



**SQL:** Google BigQuery (12 analytical queries)

**Visualization:** Microsoft Power BI (3-page dashboard)

**Version Control:** GitHub







##### **Questions Answered**



###### **Revenue Analysis**

* What is total revenue by month — is there a growth trend?
* Which product categories generate the most revenue?
* What is the average order value overall and by category?
* Which states have the highest customer concentration?



###### **Operational Performance**

* What percentage of orders are delivered late vs. on time?
* Which sellers have the highest late delivery rates?
* Which product categories take the longest to deliver?



###### **Customer Intelligence**

* What is the repeat purchase rate?
* What does month-over-month revenue growth look like?
* How do sellers rank by revenue within each category?
* How do customer cohorts retain over 3 months?
* How are customers segmented by RFM (Recency, Frequency, Monetary) value?







##### **Key Findings**



###### **1. 97% of customers never return**

Of 94,000+ unique customers, only 3% placed more than one order. One-time purchase behavior dominates the entire customer base. The business case for a retention or loyalty program is significant — even converting 5% of one-time buyers to repeat customers would meaningfully impact revenue.



###### **2. Revenue spike in November 2017**

Monthly revenue jumped sharply in November 2017, consistent with Black Friday and seasonal shopping behavior. Revenue then stabilized at \~1M/month through mid-2018, indicating sustainable growth after the initial ramp-up period.



###### **3. Office furniture averages 20+ days to deliver**

Office furniture is the slowest category by a significant margin, averaging over 20 days from order to delivery — nearly double the next slowest category. This represents a clear operational improvement opportunity.



###### **4. Only 8.11% of orders are delivered late**

Despite the volume of orders across a geographically large country, 91.89% of deliveries arrive on or before the estimated delivery date — a strong operational baseline.







##### **Dashboard Preview**



**Page 1 — Revenue Overview**

!\[Revenue Overview](dashboard/screenshots/revenue_overview.png)


**Page 2 — Operational Health**

!\[Operational Health](dashboard/screenshots/operational_health.png)



**Page 3 — Customer Intelligence**

!\[Customer Intelligence](dashboard/screenshots/customer_intelligence.png)







##### **Repository Structure**





olist-ecommerce-analysis/

│

├── README.md

├── sql/

│   ├── 01\_monthly\_revenue.sql

│   ├── 02\_category\_revenue.sql

│   ├── 03\_avg\_order\_value.sql

│   ├── 04\_customers\_by\_state.sql

│   ├── 05\_delivery\_rate.sql

│   ├── 06\_seller\_late\_rate.sql

│   ├── 07\_delivery\_by\_category.sql

│   ├── 08\_repeat\_purchase\_rate.sql

│   ├── 09\_mom\_growth\_rate.sql

│   ├── 10\_seller\_rank\_by\_category.sql

│   ├── 11\_cohort\_retention.sql

│   └── 12\_rfm\_segmentation.sql

├── dashboard/

│   ├── olist\_dashboard.pbix

│   └── screenshots/

│       ├── revenue\_overview.png

│       ├── operational\_health.png

│       └── customer\_intelligence.png

└── insights/

&#x20;   └── key\_findings.md







##### **How to Reproduce**



1\. Download the Olist dataset from \[Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

2\. Upload all CSV files to a Google BigQuery dataset

3\. Run each SQL file in `/sql` as a BigQuery View

4\. Open `olist\_dashboard.pbix` in Power BI Desktop

5\. Update the BigQuery connection to point to your project and dataset





##### **Data Notes**



* Category name translations cover most but not all products; some categories appear in Portuguese in the visuals. This is a known data quality limitation of the source dataset.
* The `order\_reviews` table was excluded from this analysis due to a file loading issue. Review score analysis is scoped for a future iteration.
* RFM reference date is set to `2018-10-01` to align with the dataset end date.





