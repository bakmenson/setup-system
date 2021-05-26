let g:startify_custom_header = [
	\ '               __                    __           ___              ',
	\ '              /\ \__                /\ \__  __  /"___\             ',
	\ '          ____\ \ ,_\    __     _ __\ \ ,_\/\_\/\ \__/  __  __     ',
	\ '         /`,__\\ \ \/  /`__`\  /\``__\ \ \/\/\ \ \ ,__\/\ \/\ \    ',
	\ '        /\__, `\\ \ \_/\ \L\.\_\ \ \/ \ \ \_\ \ \ \ \_/\ \ \_\ \   ',
	\ '        \/\____/ \ \__\ \__/.\_\\ \_\  \ \__\\ \_\ \_\  \/`____ \  ',
	\ '         \/___/   \/__/\/__/\/_/ \/_/   \/__/ \/_/\/_/   `/___/> \ ',
	\ '                                                            /\___/ ',
	\ '                                                            \/__/  ',
	\]

autocmd User Startified setlocal cursorline

let g:startify_enable_special      = 0
let g:startify_files_number        = 10
let g:startify_relative_path       = 1
let g:startify_update_oldfiles     = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_dir       = 1
let g:startify_padding_left		   = 12

let g:startify_lists = [
	\ { 'header': ['        Files'],                  'type': 'files' },
	\ { 'header': ['        Current Dir '. getcwd()], 'type': 'dir' },
	\ { 'header': ['        Sessions'],               'type': 'sessions' },
	\ { 'header': ['        Bookmarks'],			  'type': 'bookmarks' },
	\ ]

let g:startify_bookmarks = [
	\ { 'c': '~/dotfiles/i3/config' },
	\ { 'i': '~/dotfiles/nvim/init.vim' },
	\ { 'z': '~/dotfiles/zsh/.zshrc' },
	\ { 'd': '~/dotfiles' },
	\ { 's': '~/setup-system' },
	\ '~/Dev'
	\ ]
