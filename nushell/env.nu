# Nushell Environment Config File

# Use nushell functions to define your right and left prompt
# $env.PROMPT_COMMAND = { create_left_prompt }
# $env.PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
#$env.PROMPT_INDICATOR = { "〉" }
#$env.PROMPT_INDICATOR_VI_INSERT = { ": " }
#$env.PROMPT_INDICATOR_VI_NORMAL = { "〉" }
#$env.PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
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
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
$env.PATH = ($env.PATH | split row (char esep) | prepend '~/sys-git/eww/target/release/')
$env.PATH = ($env.PATH | split row (char esep) | prepend '~/.cargo/bin/')
$env.PATH = ($env.PATH | split row (char esep) | prepend '~/.local/bin/')
$env.PATH = ($env.PATH | split row (char esep) | prepend '~/miniconda3/bin/')

$env.LS_COLORS = (dircolors -b ~/.config/nushell/.dir_colors | lines | get 0 | str substring 10..)

$env.EDITOR = "nvim"

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# Prevent weird "re-prompt" behavior
sleep 100ms
