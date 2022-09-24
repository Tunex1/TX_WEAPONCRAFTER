client_scripts {
    'config.lua',
    'client.lua'
}


server_scripts {
    'config.lua',
    'server.lua',
    '@mysql-async/lib/MySQL.lua'
}


ui_page 'html/index.html'
files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/img/*.png'
}