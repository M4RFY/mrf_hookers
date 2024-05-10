fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'MARFY'
version '1.5.0'
description 'sawu_hookers converted for QBCore Framework'

shared_scripts { '@ox_lib/init.lua', 'config.lua', 'shared/*.lua' }
server_scripts { 'server/*.lua' }
client_scripts { 'client/*.lua' }

ui_page 'ui/index.html'

files {
	'ui/index.html',
    'ui/**/*'
}