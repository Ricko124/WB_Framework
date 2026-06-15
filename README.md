<p align="center">
  <img src="https://raw.githubusercontent.com/Ricko124/WB_Framework/main/WB_UI/web/logo.png" width="300">
</p>

<h1 align="center">WB_Scripts</h1>

<p align="center">
  Modern ESX Legacy Framework for FiveM
</p>

<p align="center">
  <img src="https://img.shields.io/badge/FiveM-Compatible-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Framework-ESX_Legacy-green?style=for-the-badge">
  <img src="https://img.shields.io/badge/Lua-5.4-orange?style=for-the-badge">
  <img src="https://img.shields.io/badge/Status-Active-success?style=for-the-badge">
</p>

---

# 🚀 About

**WB_Scripts** is a modern and lightweight ESX Legacy framework for FiveM servers.

The framework was designed to provide a clean, modular and expandable foundation for roleplay communities while maintaining high performance and easy customization.

Whether you are starting a new server or replacing an outdated framework, WB_Scripts provides all the essential systems needed to run a professional FiveM roleplay server.

---

# ✨ Features

### 👤 Character System

* Multi Character Support
* Character Creation
* Character Selection
* Character Management
* Identity Registration

### 🪪 Identity System

* First Name
* Last Name
* Date Of Birth
* Gender
* Height
* Character Profiles

### 🎒 Inventory System

* Custom Inventory
* Shops
* Stashes
* Vehicle Trunks
* Gloveboxes
* Item Management

### 💰 Banking

* Deposits
* Withdrawals
* Transfers
* Account Management
* Transaction Tracking

### 🚗 Garages

* Vehicle Storage
* Vehicle Spawn
* Vehicle Retrieval
* Impound Support

### 💼 Jobs

* Police
* EMS
* Mechanic
* Taxi
* Easy Job Expansion

### 📱 Phone System

* Contacts
* Messages
* Notifications
* Call Support

### 🏥 Hospital System

* Death System
* Revive System
* Respawn System

### 🛡️ Administration

* Player Management
* Revive
* Teleport
* Bring
* Goto
* Kick
* Ban

### 🔗 Discord Integration

* Join Logs
* Leave Logs
* Admin Logs
* Ban Logs
* Webhook Support

---

# 📂 Framework Structure

```text
WB_Framework/
│
├── WB_Core
├── WB_UI
├── WB_Admin
├── WB_Banking
├── WB_Discord
├── WB_Garages
├── WB_Identity
├── WB_Inventory
├── WB_Jobs
├── WB_Multichar
│
├── sql
├── server
├── fxmanifest.lua
├── README.md
└── server.cfg.example
```

---

# ⚙️ Requirements

Required:

* FiveM FXServer
* ESX Legacy
* oxmysql
* MySQL / MariaDB

Recommended:

* ox_lib
* ox_target
* pma-voice

---

# 📥 Installation

### 1. Upload Framework

Place the complete `WB_Framework` folder into your resources directory.

### 2. Import Database

Import:

```sql
sql/wb_scripts.sql
```

into your MySQL database.

### 3. Configure Database

Add your database connection to your server configuration:

```cfg
set mysql_connection_string "mysql://USER:PASSWORD@127.0.0.1/DATABASE?charset=utf8mb4"
```

### 4. Start Framework

Add:

```cfg
ensure WB_Framework
```

to your `server.cfg`.

---

# 📜 Example server.cfg

```cfg
ensure oxmysql
ensure es_extended

ensure WB_Framework
```

---

# 🔧 Configuration

Configuration files can be found inside:

```text
shared/config.lua
```

within each module.

---

# 📊 Included Modules

| Module       | Description         |
| ------------ | ------------------- |
| WB_Core      | Framework Core      |
| WB_UI        | UI & HUD            |
| WB_Admin     | Administration      |
| WB_Banking   | Banking System      |
| WB_Discord   | Discord Logs        |
| WB_Garages   | Vehicle Garages     |
| WB_Identity  | Character Identity  |
| WB_Inventory | Inventory System    |
| WB_Jobs      | Job Management      |
| WB_Multichar | Character Selection |

---

# 🔄 Updating

1. Stop the server
2. Replace framework files
3. Import SQL updates
4. Delete cache
5. Restart server

---

# ❤️ Credits

### Developer

**Ricko124**

GitHub:

https://github.com/Ricko124/WB_Framework

---

# 📄 License

This project is provided for private and community use.

Selling, redistributing or reuploading modified versions without permission is prohibited.

---

<p align="center">
  Made with ❤️ by Ricko124
</p>
