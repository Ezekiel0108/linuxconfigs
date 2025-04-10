# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

#starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

#text editor
$env.config.buffer_editor = "nvim"

#disable startup banner
$env.config.show_banner = false

#ls to eza
alias l = eza -lh  --icons=auto
alias la = eza -a -1 --icons=auto
alias ls = eza -1   --icons=auto
alias ll = eza -lha --icons=auto
alias ld = eza -lhD --icons=auto
alias lt = eza --icons=auto --tree

#cd shortcuts
alias .. = z ..
alias ... = z ../..

#convert kill to killall
alias kill = killall

#ls for date of installed pacmans in  a cool table :)
alias lspd = ~/Scripts/archNuLsDate.sh

#see most used commands
alias lsmuc = ~/Scripts/mostUsedCommands.sh

#activate/disable ollama service

alias ollamaOn = sudo systemctl start ollama.service
alias ollamaOff = sudo systemctl stop ollama.service

#zoxide
source ~/.zoxide.nu
alias cd = __zoxide_z

#use fzf with preview(bat)
 alias fzf = fzf  --style full --preview="bat --color=always {}"

#replacing grep with ripgrep
alias grep = rg --color=always

#env variables
$env.config.completions.use_ls_colors = false

#$env.config = {

# color_config: {

#   shape_external: red
#   shape_external_resolved: cyan_underline
#   shape_internalcall: cyan_underline
#   shape_custom: cyan_underline
#   shape_externalarg: yellow
#   shape_externalarg_resolved: yellow_underline
#   shape_string_interpolation: purple_underline

# }
#}





