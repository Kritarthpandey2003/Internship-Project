# Sports Tournament Tracker

##  Overview
This project implements a **SQL-based Sports Tournament Tracker** to manage match results, player statistics, and team performance reports.  
It enables recording of tournament data, generates player & team leaderboards, and analyzes individual performance trends.

---

##  Objective
- Record details of teams, players, matches, and player statistics.
- Track match results and identify winning teams.
- Generate leaderboards for players and teams.
- Analyze average player performance using CTEs.
- Export performance reports in `.csv` format.

---

##  Tools Used
- MySQL Workbench
- SQL (DDL, DML, Views, CTEs)
- CSV export feature of MySQL Workbench

---

##  Database Schema
### Tables:
- **Teams**: Stores team information.
- **Players**: Players associated with teams.
- **Matches**: Matches played between two teams with result.
- **Stats**: Player performance stats in each match.

### ER Diagram
(Attached `ER_DIAGRAM_sports_tracker.png`)

---

##  Key Features
 Normalized relational schema with foreign key constraints.  
 Sample data for teams, players, matches, and stats.  
 Queries to retrieve match results, player scores.  
 Views for player leaderboard & team points table.  
 CTE to calculate average player performance metrics.  
 Exportable reports in `.csv` format.

---

##  How to Run
 Open `sports_tournament.sql` in MySQL Workbench.  
 Execute the script to create tables, insert sample data, and define views & CTEs.  
 Run queries like:
- Match Results:
  ```sql
  SELECT * FROM Matches;

Player Scores:

SELECT * FROM Stats WHERE match_id = 1;

Player Leaderboard:

SELECT * FROM player_leaderboard;

Team Points Table:

SELECT * FROM team_points;

Average Player Performance:

WITH avg_performance AS (
    SELECT player_id, AVG(runs) AS avg_runs, AVG(wickets) AS avg_wickets, AVG(catches) AS avg_catches
    FROM Stats
    GROUP BY player_id
)
SELECT p.player_name, a.avg_runs, a.avg_wickets, a.avg_catches
FROM avg_performance a
JOIN Players p ON a.player_id = p.player_id;
