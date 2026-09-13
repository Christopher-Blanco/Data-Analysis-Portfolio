## 🎮 Global Video Game Market Analysis (1980–2020)
## Project overview

Exploratory analysis and data visualization of the video game industry’s evolution across four decades (1980–2020). The goal is to go beyond raw sales and highlight the cultural, economic, and technological forces that shaped consumer demand across regions.

<aside>


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

 ---

### 📌 Global Sales Analysis by Genre

*A snapshot of global sales segmented by genre.*
<img width="1336" height="719" alt="1" src="https://github.com/user-attachments/assets/8064ac98-f913-41ff-861f-e7e136720292" />

An aggregate analysis of global sales reveals a clear dominance of the **Shooter** and **Action** genres as the primary financial drivers of the film and interactive video game industries.

### **Key Insights:**

- **Dominance of the Annual Release Model (Shooters):** The *Shooter* genre leads the global market with over 611 million units sold. This phenomenon is strongly driven by franchises with high release frequency and brand loyalty, such as *Call of Duty* (Activision), whose strategy of sustained annual releases since 2005 maintains a steady revenue stream.
- **Longevity and Long-Term Monetization (Action):** The *Action* genre (535.4M) holds a firm second place. Unlike annual releases, this sector stands out for the longevity of mega-hits such as *Grand Theft Auto V* and *Red Dead Redemption* (Rockstar Games). These titles demonstrate the success of the strategy of intergenerational “remasters” (e.g., from PS3 to PS4/PS5), technical optimizations (loading screens, graphical enhancements), and the robustness of their multiplayer components, which keep the games relevant and profitable for years.
- **Market Concentration:** The top four genres (*Shooter*, *Action*, *Sports*, and *Role-Playing*) account for the vast majority of global sales, leaving niche games (such as *Strategy*, *Music*, or *MMO*) with a marginal share.

> 🔍 **Transition Note:** Although the global landscape shows a clear preference for action and shooting games, this order is not absolute. When segmenting this data regionally in subsequent analyses, it will become clear how cultural factors drastically alter consumer preferences (for example, the prominence of RPGs in Asian markets).
>
> ---
### 🏆 Top 10 Publishers by Global Sales (Units Sold)

*Who dominates the market, and how concentrated is publisher revenue?*
<img width="1332" height="722" alt="2" src="https://github.com/user-attachments/assets/29a34eb8-a744-4526-99d5-4217cc009466" />

This analysis identifies the market leaders and validates the findings of the genre report, demonstrating that companies with recurring franchises or titles with high replay value dominate the industry’s revenue.

### **Key Insights:**

- **The Consistency of the Subscription and Annual Release Model:** **Activision** (334.32M) and **Electronic Arts** (330.73M) lead the global market in a virtual tie. Activision’s success is driven by the annual release of *Call of Duty* combined with the exploitation of nostalgia and replay value of classic IPs such as *Crash Bandicoot*. For its part, EA replicates this success through high-fidelity sports simulators and massive franchises (such as the *F1* and *Madden NFL* series), complemented by large-scale shooters like *Battlefield* and long-cycle life simulators like *The Sims*.
- **The Impact of Data Fragmentation (EA vs. EA Sports):** A critical finding in the data structure is the separation of *Electronic Arts* and *EA Sports* (165.84M) as independent entities. From a business perspective, if we consolidate both brands under EA’s corporate umbrella, their combined sales volume would total **496.57M**, positioning the company as the undisputed global market leader by a wide margin.
- **Quality and Longevity Over Quantity (Rockstar Games):** Ranked third with 190.27M, **Rockstar Games** demonstrates a strategy that runs counter to annualization. Its model is based on releasing massive content titles with hundreds of hours of gameplay (*Grand Theft Auto*, *Red Dead Redemption*) and extending their commercial lifecycle across multiple console generations through remasters and ongoing support for their online modes.
- **Regional Diversity and Established Niches:** The Top 10 also highlights the strong presence of traditional Asian giants such as **Konami** (90.01M) and **Capcom** (89.18M), which have maintained their global relevance over the decades by preserving and modernizing historic franchises.
- ---
### 🎮 Analysis of Global Software Sales by Console
*Which consoles led software sales, and what business factors explain the ranking?*
<img width="1339" height="716" alt="3" src="https://github.com/user-attachments/assets/e03d64c3-9476-4c33-a99b-6cf33589cec3" />
## **Key Insights and Business Findings:**

The Seventh Generation (PS3 and X360): The PS3 tops the global list with over 570 million game copies sold, closely followed by the Xbox 360 (525.5 million). The PS3’s success was cemented by the strong pull of historically renowned franchises and big-budget (AAA) titles such as Grand Theft Auto, Call of Duty, and critically acclaimed exclusives like the Uncharted, God of War, and The Last of Us series.

The PlayStation Phenomenon in the Americas: The data reflects the enormous brand loyalty that Sony has built in the region. The PS3 inherited a massive fan base thanks to the legacy of its previous classic consoles, making it a platform with sustained and massive demand for titles in popular genres such as action, shooters, and adventure (Crash, Red Dead Redemption, etc.).

🔍 Analysis Note (Unexpected Finding):

⚠️ Software vs. Hardware: A highly interesting finding in this query is the position of the PS2 (371.6 million games). Historically, the PS2 is the best-selling console of all time in terms of hardware (physical consoles). However, when analyzing only sales of original games, it falls to fourth place behind the PS3, X360, and PS4.

**Note:** This phenomenon can be directly attributed to external market factors at the time, primarily the high rates of piracy the platform suffered globally. Despite millions of active consoles in households, a massive portion of software consumption was not recorded in official legal sales metrics.
“This phenomenon can be directly attributed to external market factors at the time, primarily the high rates of piracy the platform suffered globally. Despite millions of active consoles in households, a massive portion of software consumption was not recorded in official legal sales metrics.
 ---
 ### 🕹️ Top 10 Best-Selling Video Games (By Platform)

*Which titles lead by console, and what business patterns explain their success?*
<img width="1337" height="714" alt="4" src="https://github.com/user-attachments/assets/989cb53a-0dea-421e-8f5a-4d0cc8defeb6" />
### **Key Insights (Business + Market)**

- **“Mega-franchise” multiplatform effect (Rockstar):** *Grand Theft Auto V* leads the ranking thanks to an intergenerational, multiplatform expansion strategy (constant remasters and strong presence on PS3, PS4, and Xbox 360). This approach turns a single product into a long-running sales engine, reducing the need to rely on annual releases.
- **Brand equity and nostalgia (classics that don’t expire):** *GTA: Vice City* (PS2) shows how strong brand equity can translate into massive sales even on older hardware. Its aesthetics, narrative, and soundtrack (80s setting) created a powerful emotional differentiator that sustained demand over time, especially in key markets like Europe.
- **Instant FPS pull and the iteration model (Call of Duty):** The heavy presence of *Call of Duty* in the Top 10 confirms FPS as a high-velocity, repeat-consumption genre—driven by competitive communities, frequent release cycles, and a player base that migrates across generations (X360, PS3, PS4).
- **Cinematic action and open worlds as a long-cycle bet:** The appearance of titles like *Red Dead Redemption 2* reinforces that narrative open-world games can compete at the very top when they combine quality, scale, and cultural conversation (awards, streaming, community), extending their commercial life well beyond launch peak.

“Note: The data shows sales broken down by platform; if grouped by title, GTA V and the Call of Duty series would emerge as the undisputed leaders of all time.”
---
### 🗺️ Consumer Preferences: Japan (JP)

*Which genres lead in Japan, and what cultural/business factors explain these preferences?*
<img width="1338" height="710" alt="5" src="https://github.com/user-attachments/assets/3b1b1684-6570-4618-b55e-54196084794b" />
### **Key Insights:**

- **The Undisputed King: Role-Playing Games:** Unlike the markets in the Americas and Europe (where action and shooter genres typically dominate the top spot), in Japan the role-playing genre leads with 47.66 million copies sold. This phenomenon is due to the enormous cultural influence of legendary local franchises (such as Pokémon, Dragon Quest, and Final Fantasy), which are deeply rooted in the Japanese consumer’s identity.
- **The Cultural Contrast of Shooters:** While in the West, shooter games are among the most in-demand products, in Japan they drop sharply to fourth place (22.41 million). The Japanese public has historically prioritized strategy mechanics, character development, and complex narratives over competitive first-person shooter experiences.
- **The Importance of Portability and Social Interaction:** The Action (39.32 million), Sports (31.35 million), and Fighting (21.05 million) genres maintain strong positions. In Japanese society, personal space at home and daily commute times directly influence the data; hence the immense popularity of games suited for handheld consoles and quick or local face-to-face cooperative play.

> 🔍 **Business Conclusion (Strategy Localization):**
💡 Business Insight: This analysis demonstrates that the video game industry cannot be approached with a unified global strategy. A publisher or developer attempting to launch a video game in the Japanese market must understand that commercial success depends critically on product localization and tailoring marketing toward Role-Playing and Action experiences, as consumer behavior is diametrically opposed to that of American or European markets.
> ---
### 🗺️ Consumer Preferences: North America (NA)

*Which genres dominate North America, and what market and economic forces shape the ranking?*
<img width="1338" height="717" alt="6" src="https://github.com/user-attachments/assets/4924eff5-d6fa-4378-8c1f-31e2eea6c6fc" />
### **Key Insights:**

- **The Blockbuster and Action Culture:** In stark contrast to Japan, the North American market is absolutely dominated by the Shooter (301.93 million) and Action (247.20 million) genres. This market trend is directly driven by the massive success of big-budget multiplatform titles focused on online and competitive play, such as the Call of Duty and Grand Theft Auto (GTA) franchises.
- **The Resilience of Role-Playing Games (RPGs):** Despite not taking the top spot, the RPG genre remains strong in fourth place with 103.71 million copies sold. This demonstrates that iconic franchises like Pokémon and Final Fantasy enjoy massive brand recognition and fame in this part of the world, successfully captivating a critical mass of loyal consumers.

> 🔍 **Analysis of Market Barriers and Economic Impact:**
⚠️ **The Economic Hurdle in Sales Figures:** When analyzing why the RPG genre does not reflect even higher numbers in the region, very specific commercial and economic factors come into play:
> 
- **Rigid Pricing Strategy (Nintendo):** Key franchises like Pokémon belong to the Nintendo ecosystem, a company known for maintaining extremely strict pricing policies. Its titles rarely depreciate or drop in price over time, and the exclusivity of its hardware limits accessibility.
- **Grey Market and Emulation:** The high cost of original games, combined with regional socioeconomic factors, acts as a major barrier to legal consumption. This drives a large portion of the gaming community to opt for unofficial alternative methods (such as emulators and ROM downloads).
  ---
  ### 🌟 Quality vs. Commercial Success

*Which games earned the highest critic scores, and what design choices explain their acclaim beyond sales?*
<img width="1337" height="716" alt="7" src="https://github.com/user-attachments/assets/98649161-0741-4358-92f5-599dda8c0849" />
### **Key Insights:**

- **The Value of Immersion and Narrative Excellence (RDR2 at the Top):** With a near-perfect score of 9.8, Red Dead Redemption 2 tops the charts. The qualitative analysis behind this data shows that critics reward games that achieve a deep emotional connection through a solid story and the evolution of characters with whom the player empathizes (such as Arthur Morgan’s redemption). This is complemented by a massive map focused on ultra-realism, obsessive attention to detail, organic side missions, and an immersive soundtrack that maximizes the experience.
- **The Balance Between Depth and Replayability (The Case of GTA V):** Grand Theft Auto V (9.7) ranks second. Although the general consumer perception is that its narrative lacks the dramatic depth of RDR2, the title compensates and secures its high rating thanks to an extremely versatile map design, exceptionally high replayability through dynamic character switching, and a massive sandbox of vehicles and weapons that keeps it relevant and beloved by the public.
- **Quality Metrics vs. Simple Game Loops:** A critical finding when examining the Top list is the absence from the top ranks of simple combat genres (such as Mortal Kombat) or recurring shooter installments (such as most of the Call of Duty series, with historical exceptions like Modern Warfare at 9.6). This demonstrates that a high critical score does not define a game that you simply “play to pass the time,” but rather projects that prioritize strong mechanics, attention to detail, and interactive worlds.

> 🔍 **Business Conclusion:**
💡 The Cultural Connection to Role-Playing: This critical trend toward complex narratives and detailed worlds perfectly explains why, culturally speaking in regions like Japan, role-playing (RPG) genres naturally dominate. The critical and analytical consumer seeks experiences where decisions, stories, and deep gameplay sustain the product over the long term, rather than relying solely on fleeting trends in fast-paced gaming.
>
