# fish completion for playerctl

function __fish_playerctl_players 
  playerctl --list-all
end

function __fish_playerctl_metadata_keys
  playerctl metadata | awk '{ print $2 }'
end

# Subcommands
set -l subcommands play pause play-pause stop next previous position volume status metadata open loop shuffle

set -l loop_args None Track Playlist
set -l shuffle_args On Off Toggle

# Disable file completions for the entire command
complete -c playerctl -f

complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "play" -d "Command the player to play"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "pause" -d "Command the player to pause"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "play-pause" -d "Command the player to toggle between play/pause"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "stop" -d "Command the player to stop"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "next" -d "Command the player to skip to the next track"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "previous" -d "Command the player to skip to the previous track"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "position" -d "Command the player to go to the position or seek forward/backward OFFSET in seconds"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "volume" -d "Print or set the volume to LEVEL from 0.0 to 1.0"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "status" -d "Get the play status of the player"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "metadata" -d "Print metadata information for the current track"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "open" -d "Command the player to open given remote URI or file path"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "loop" -d "Print or set the loop status"
complete -c playerctl -n "not __fish_seen_subcommand_from $subcommands" -a "shuffle" -d "Print or set th shuffle status"

complete -c playerctl -n "__fish_seen_subcommand_from loop" -a "$loop_args"
complete -c playerctl -n "__fish_seen_subcommand_from shuffle" -a "$shuffle_args"

complete -c playerctl -n "__fish_seen_subcommand_from metadata; and not __fish_seen_subcommand_from (__fish_playerctl_metadata_keys)" -a "(__fish_playerctl_metadata_keys)"

complete -c playerctl -l "help" -s "h" -d "Show help options"
complete -c playerctl -l "player" -s "p" -d "A comma separated list of names of players to control"
complete -c playerctl -l "all-players" -s "a" -d "Select all available players to be controlled"
complete -c playerctl -l "ignore-player" -s "i" -d "A comma separated list of nmaes of players to ignore"
complete -c playerctl -l "format" -s "f" -d "A format string for printing properties and metadata"
complete -c playerctl -l "follow" -s "F" -d "Block and appedn the query to output when it changes for the most recently updated player"
complete -c playerctl -l "list-all" -s "l" -d "List the names of running players that can be controlled"
complete -c playerctl -l "no-messages" -s "s" -d "Suppress diagnostic messages"
complete -c playerctl -l "version" -s "v" -d "Print version information"
