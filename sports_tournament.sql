use PROJECTB;
DROP TABLE IF EXISTS Stats;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Teams;
CREATE TABLE Teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(50),
    coach_name VARCHAR(50)
);
CREATE TABLE Players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    player_name VARCHAR(50),
    role VARCHAR(20), -- e.g., Batsman, Bowler, etc.
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);
CREATE TABLE Matches (
    match_id INT AUTO_INCREMENT PRIMARY KEY,
    match_date DATE,
    team1_id INT,
    team2_id INT,
    venue VARCHAR(50),
    winner_team_id INT,
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
    FOREIGN KEY (winner_team_id) REFERENCES Teams(team_id)
);
CREATE TABLE Stats (
    stat_id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT,
    player_id INT,
    runs INT DEFAULT 0,
    wickets INT DEFAULT 0,
    catches INT DEFAULT 0,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);
INSERT INTO Teams (team_name, coach_name) VALUES
('Warriors', 'Coach A'),
('Titans', 'Coach B');
INSERT INTO Players (team_id, player_name, role) VALUES
(1, 'Player 1', 'Batsman'),
(1, 'Player 2', 'Bowler'),
(2, 'Player 3', 'Batsman'),
(2, 'Player 4', 'Bowler');
INSERT INTO Matches (match_date, team1_id, team2_id, venue, winner_team_id) VALUES
('2025-07-10', 1, 2, 'Stadium X', 1);
INSERT INTO Stats (match_id, player_id, runs, wickets, catches) VALUES
(1, 1, 50, 0, 1),
(1, 2, 10, 2, 0),
(1, 3, 30, 0, 2),
(1, 4, 5, 1, 1);
SELECT m.match_id, m.match_date, t1.team_name AS Team1, t2.team_name AS Team2, t3.team_name AS Winner, m.venue
FROM Matches m
JOIN Teams t1 ON m.team1_id = t1.team_id
JOIN Teams t2 ON m.team2_id = t2.team_id
JOIN Teams t3 ON m.winner_team_id = t3.team_id;
SELECT p.player_name, s.runs, s.wickets, s.catches
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
WHERE s.match_id = 1;
CREATE OR REPLACE VIEW player_leaderboard AS
SELECT p.player_name, t.team_name,
       SUM(s.runs) AS total_runs,
       SUM(s.wickets) AS total_wickets,
       SUM(s.catches) AS total_catches
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
JOIN Teams t ON p.team_id = t.team_id
GROUP BY p.player_id
ORDER BY total_runs DESC;
CREATE OR REPLACE VIEW team_points AS
SELECT t.team_name, COUNT(m.match_id) AS matches_won
FROM Matches m
JOIN Teams t ON m.winner_team_id = t.team_id
GROUP BY t.team_id
ORDER BY matches_won DESC;

WITH avg_performance AS (
    SELECT player_id,
           AVG(runs) AS avg_runs,
           AVG(wickets) AS avg_wickets,
           AVG(catches) AS avg_catches
    FROM Stats
    GROUP BY player_id
)
SELECT p.player_name, a.avg_runs, a.avg_wickets, a.avg_catches
FROM avg_performance a
JOIN Players p ON a.player_id = p.player_id;
SELECT * FROM team_points;
SELECT * FROM player_leaderboard;