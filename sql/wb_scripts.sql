CREATE TABLE IF NOT EXISTS wb_accounts (
  license VARCHAR(80) PRIMARY KEY,
  username VARCHAR(50) NULL UNIQUE,
  password VARCHAR(255) NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS wb_characters (
  id INT AUTO_INCREMENT PRIMARY KEY,
  license VARCHAR(80) NOT NULL,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  dateofbirth VARCHAR(10) NOT NULL,
  sex VARCHAR(10) NOT NULL,
  height INT DEFAULT 180,
  skin LONGTEXT,
  job VARCHAR(60) DEFAULT 'unemployed',
  job_grade INT DEFAULT 0,
  bank INT DEFAULT 5000,
  cash INT DEFAULT 1000,
  spawned TINYINT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP NULL,
  INDEX idx_license (license)
);
CREATE TABLE IF NOT EXISTS wb_items (
  id VARCHAR(50) PRIMARY KEY,
  label VARCHAR(100) NOT NULL,
  weight INT DEFAULT 0,
  rarity VARCHAR(20) DEFAULT 'common',
  description TEXT,
  usable TINYINT DEFAULT 0,
  stackable TINYINT DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS wb_inventory (
  id INT AUTO_INCREMENT PRIMARY KEY,
  character_id INT NOT NULL,
  item_id VARCHAR(50) NOT NULL,
  count INT DEFAULT 0,
  metadata LONGTEXT,
  UNIQUE KEY inv_item (character_id, item_id)
);
CREATE TABLE IF NOT EXISTS wb_bank_accounts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  character_id INT NOT NULL,
  balance INT DEFAULT 0,
  holder_name VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY bank_char (character_id)
);
CREATE TABLE IF NOT EXISTS wb_bank_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  account_id INT NULL,
  type VARCHAR(50),
  amount INT,
  balance_before INT,
  balance_after INT,
  reason VARCHAR(200),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS wb_jobs (
  id VARCHAR(60) PRIMARY KEY,
  label VARCHAR(100) NOT NULL,
  description TEXT,
  type VARCHAR(20) DEFAULT 'service',
  boss_position LONGTEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS wb_job_grades (
  id INT AUTO_INCREMENT PRIMARY KEY,
  job_id VARCHAR(60) NOT NULL,
  grade INT DEFAULT 0,
  label VARCHAR(100) NOT NULL,
  salary INT DEFAULT 0,
  UNIQUE KEY unique_grade (job_id, grade)
);
CREATE TABLE IF NOT EXISTS wb_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(50) NOT NULL,
  message TEXT NOT NULL,
  data LONGTEXT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_category (category)
);
CREATE TABLE IF NOT EXISTS wb_stashes (id INT AUTO_INCREMENT PRIMARY KEY, stash VARCHAR(100) NOT NULL, item VARCHAR(80) NOT NULL, count INT NOT NULL DEFAULT 0, UNIQUE KEY stash_item (stash, item));
CREATE TABLE IF NOT EXISTS wb_societies (job VARCHAR(60) PRIMARY KEY, money INT DEFAULT 0);
CREATE TABLE IF NOT EXISTS wb_garage_vehicles (
  plate VARCHAR(16) PRIMARY KEY,
  owner VARCHAR(80) NOT NULL,
  vehicle LONGTEXT NOT NULL,
  garage VARCHAR(80) DEFAULT 'legion',
  stored TINYINT DEFAULT 1,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_owner (owner)
);
CREATE TABLE IF NOT EXISTS wb_phone_logs (id INT AUTO_INCREMENT PRIMARY KEY, from_number VARCHAR(20) NOT NULL, to_number VARCHAR(20) NOT NULL, message TEXT NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS wb_shops (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL, type VARCHAR(50), x FLOAT, y FLOAT, z FLOAT, heading FLOAT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

INSERT IGNORE INTO wb_items (id, label, weight, stackable, description) VALUES
('phone','Telefon',50,0,'Kommunikationsgerät'),('water','Wasser',100,1,'Flasche Wasser'),('burger','Burger',200,1,'Essen'),('bandage','Bandage',100,1,'Medizinisches Item');
INSERT IGNORE INTO wb_jobs (id,label,description,type) VALUES
('unemployed','Arbeitslos','Keine Beschäftigung','service'),('police','Polizei','Sicherheit und Ordnung','government'),('ambulance','Rettungsdienst','Medizinische Hilfe','government'),('taxi','Taxi','Transport','service'),('mechanic','Mechaniker','Fahrzeugservice','service');
INSERT IGNORE INTO wb_job_grades (job_id,grade,label,salary) VALUES
('unemployed',0,'Arbeitslos',0),('police',0,'Rekrut',500),('police',1,'Officer',800),('ambulance',0,'Azubi',500),('taxi',0,'Fahrer',350),('mechanic',0,'Azubi',350);
CREATE TABLE IF NOT EXISTS wb_bans (
  id INT AUTO_INCREMENT PRIMARY KEY,
  identifier VARCHAR(120) NOT NULL,
  reason VARCHAR(255),
  banned_by VARCHAR(100),
  active TINYINT DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_identifier (identifier)
);
ALTER TABLE wb_stashes MODIFY stash VARCHAR(140) NOT NULL;
