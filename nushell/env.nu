# Nushell Environment Config File

# Use nushell functions to define your right and left prompt
# let-env PROMPT_COMMAND = { create_left_prompt }
# let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
#let-env PROMPT_INDICATOR = { "〉" }
#let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
#let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
#let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
let-env PATH = ($env.PATH | split row (char esep) | prepend '~/sys-git/eww/target/release/')

let-env LS_COLORS = (dircolors -b ~/.config/nushell/.dir_colors | lines | get 0 | str substring '10,')

let-env EDITOR = "vim"

mkdir ~/.cache/starship
starship init nu | save ~/.cache/starship/init.nu
