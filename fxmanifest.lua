fx_version 'adamant'
game 'gta5'

author 'A̴k̴a̴s̴h̴i̴#0007'

shared_script 'config.lua'

client_scripts {
    'modules/RMenu.lua',
    'modules/menu/RageUI.lua',
    'modules/menu/Menu.lua',
    'modules/menu/MenuController.lua',
    'modules/components/*.lua',
    'modules/menu/elements/*.lua',
    'modules/menu/items/*.lua',
    'modules/menu/panels/*.lua',
    'modules/menu/windows/*.lua',
    'modules/xSound/client/*.lua',
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

ui_page 'modules/xSound/html/index.html'
files {
    'modules/xSound/html/index.html',
    'modules/xSound/html/*.css',
    'modules/xSound/html/scripts/listener.js',
    'modules/xSound/html/scripts/SoundPlayer.js',
    'modules/xSound/html/scripts/functions.js',
    'modules/xSound/html/diplayLogo.js',
    'modules/xSound/html/toastr.min.js',
    'modules/xSound/html/img/*.png',
}