## 🎮 Global Video Game Market Analysis (1980–2020)
## Project overview

Exploratory analysis and data visualization of the video game industry’s evolution across four decades (1980–2020). The goal is to go beyond raw sales and highlight the cultural, economic, and technological forces that shaped consumer demand across regions.

<aside>
🎮

**Scope:** Global market (1980–2020)

**Focus:** Regional preferences, long-term franchises, pricing/piracy effects, and platform dynamics.

</aside>

---

## Objectives & lines of research

1. **Cultural and regional preferences (🌍)**  
    
    Visualize how culture influences purchasing patterns by region, and which genres/titles dominate each market.
    
2. **Legacy vs. fleeting trends (⏳)**  
    
    Identify franchises that stay relevant over time vs. games that created a sharp, short-lived inflection in the market.
    
3. **Irrelevance of series size**  
    
    Case studies of developers/publishers with few releases that still achieved outsized historical relevance and sales.
    
4. **Hardware vs. software paradox (🔌)**  
    
    Test whether hardware success correlates with legal software sales—or if the relationship breaks by platform/region.
    
5. **External factors: piracy & unauthorized distribution (☠️)**  
    
    Evaluate how piracy affected performance of key platforms/titles in specific regions and time periods.
    
6. **Economic barriers & pricing strategies (💰)**  
    
    Analyze how launch pricing and limited price drops shaped adoption in developing regions.
    

---

## Tools & workflow

### Data work

- **SQL** — segmentation, cleaning, and advanced historical queries.
- **Python** — EDA, feature engineering, and deeper statistical exploration.

### Visualization & storytelling

- **Power BI / dashboards** — interactive views for sales by region, platform, and time.

---

## 📊 Data Source and Structure

The data used in this project comes from **Maven Analytics**. The dataset includes a massive historical record of titles with key variables for business and market analysis, such as:

- **Title Information:** Video game name, genre, and *publisher*.
- **Quality Metrics:** *Critic Score* (score from specialized critics).
- **Commercial Performance Metrics:** Sales broken down by geographic region and global sales.

---

## ⚙️ Methodology and Processing (Step-by-Step)

The project was carried out following a structured data analysis pipeline:

### 1. Initial Exploration and Cleaning (Python on Google Colab)

- **Data Audit:** Importing the original dataset into a Jupyter Notebook environment to assess the overall structure (number of rows, data types by column, and presence of null or missing values).
- **Sanitization:** Cleaning and normalizing the format of release dates.
- **Early Exploratory Analysis (EDA):** Formulating initial hypotheses in preparation for subsequent processing.
- **Export:** Conversion of the cleaned dataset to a structured flat format (`.csv`) to ensure interoperability with other tools.

### 2. Advanced Analysis Using Queries (SQL)

- **Business Strategy:** Leveraging domain knowledge of the video game industry, specific SQL queries were designed to answer critical questions about cultural shifts, regional dynamics, and historical pricing behavior.
- **Insight Extraction:** Execution of optimized queries to extract hidden patterns and key trends that served as the analytical foundation for the project.

### 3. Modeling and Interactive Visualization (Power BI)

- **Data Transformation (Power Query):** During the data load, an issue was identified with the tabular format of the regions. This was resolved by applying an **Unpivot** transformation, normalizing the structure to enable optimal multidimensional analysis.
- **Dashboard Design:** Creation of a dynamic visual report using advanced components such as:
    - *Clustered Bar Charts* and *Stacked Column Charts* to compare sales performance across platforms.
    - *Donut Charts* for the percentage distribution of genres and markets.
    - Interactive *Slicers* to filter by time periods, consoles, and regions.
   
    - ## 🖥️ Interactive Business Intelligence Dashboard

Below is the general overview of the developed dashboard. This interactive report was designed to provide an intuitive way to explore historical sales, regional distributions, and platform performance.

- **Interactive Features:** Readers can use the slicers at the top (Publisher, Console, Region, Genre, and Year) to filter the entire dataset and discover localized trends.
- **Key Visualizations:**
    - **Global Sales Distribution by Region:** A donut chart highlighting the weight of each major market.
    - **Historical Sales Trends:** A stacked column chart that visually maps the industry's growth and contraction from 1980 to 2020.
    - **Genre and Console Rankings:** Clustered bar charts identifying the historical leaders in platform sales and cultural genre preferences.
<img width="1119" height="629" alt="dashboard" src="https://github.com/user-attachments/assets/8d713d41-37cc-432a-a2d1-a4a94e028ae2" />

  ### Project Analysis: “Game Market”

### 📌 Global Sales Analysis by Gender

*A snapshot of global sales segmented by gender.*
