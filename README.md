# WB_Scripts / WB_Framework

**WB_Framework** ist der Hauptordner und Loader.  
**WB_Scripts** ist das sichtbare Branding.  
Die einzelnen technischen Ressourcen heißen `WB_Core`, `WB_UI`, `WB_Admin`, `WB_Banking`, `WB_Discord`, `WB_Garages`, `WB_Identity`, `WB_Inventory`, `WB_Jobs` und `WB_Multichar`.

## Installation

1. Den Ordner `WB_Framework` in deinen FiveM `resources` Ordner legen.
2. Datenbank importieren:

```sql
sql/wb_scripts.sql
```

3. `server.cfg` konfigurieren:

```cfg
ensure oxmysql
ensure es_extended
ensure WB_Framework
```

Der Loader startet danach automatisch:

```text
WB_Core
WB_UI
WB_Discord
WB_Identity
WB_Multichar
WB_Banking
WB_Inventory
WB_Jobs
WB_Garages
WB_Admin
```

## Wichtig

Die Unterressourcen müssen mit ihren Ordnernamen erhalten bleiben. Nicht alles in einen einzelnen Ordner ohne Unterordner kopieren.

## Branding

Sichtbares Branding: `WB_Scripts`  
Hauptordner / Loader: `WB_Framework`

## Start

In der `server.cfg` reicht:

```cfg
ensure WB_Framework
```

## Voraussetzungen

- FXServer / FiveM Artifacts
- ESX Legacy / `es_extended`
- `oxmysql`
- MySQL oder MariaDB
- OneSync empfohlen

## Hinweis

Ein Live-Test auf deinem Server ist trotzdem nötig, weil ESX-Versionen, Datenbankstruktur und vorhandene Ressourcen unterschiedlich sein können.
