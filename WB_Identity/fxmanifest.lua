fx_version 'cerulean'
game 'gta5'
lua54 'yes'

dependencies {
  'es_extended',
  'oxmysql'
}

shared_scripts {
  '@es_extended/imports.lua',
  'shared/*.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua'
}

client_scripts {
  'client/*.lua'
}

files {
  'web/app.js',
  'web/customization.html',
  'web/index.html',
  'web/logo.png',
  'web/style.css'
}

ui_page 'web/index.html'
