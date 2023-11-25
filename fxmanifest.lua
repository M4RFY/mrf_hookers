fx_version 'bodacious'
game 'gta5'

author 'MARFY'
version '1.3.0'
description 'sawu_hookers converted for QBCore Framework'

shared_scripts { '@ox_lib/init.lua', 'config.lua', 'shared/*.lua' }
server_scripts { 'server/*.lua' }
client_scripts { 'client/*.lua' }

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/libraries/axios.min.js',
	'ui/libraries/vue.min.js',
	'ui/libraries/vuetify.css',
	'ui/libraries/vuetify.js',
	'ui/script.js',
	'ui/style.css',
	'ui/img/*.png',
}

lua54 'yes'