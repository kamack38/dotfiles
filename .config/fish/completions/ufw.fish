# source: https://github.com/joxcat/omf-ufw/blob/master/completions/ufw.fish
function __fish_ufw_rule
  sudo ufw status numbered | sed -e 's/\[ /\[/g' | sed -Ee 's/\s{2,}/  /g' | awk -F"  " '{if (NR > 4 && NF > 1) {printf "%-25s%-11s%-20s%s\n", $1,$2,$3,$4}}' | awk -F"(\[|\])" '{print $2}'
end

# UFW
complete -c ufw -f
set -l ufw_commands enable disable reload reset status version default allow deny reject limit help delete
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a enable -d "enables the firewall"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a disable -d "disables the firewall"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a reload -d "reload firewall"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a reset -d "reset the firewall"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a status -d "show firewall status"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a version -d "display version information"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a default -d "set default policy"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a allow -d "add allow rule"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a deny -d "add deny rule"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a reject -d "add reject rule"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a limit -d "add limit rule"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a help -d "show help"
complete -c ufw -n "not __fish_seen_subcommand_from $ufw_commands" -a delete -d "delete rule"

# Status
set -l status_commands verbose numbered
complete -c ufw -n "__fish_seen_subcommand_from status; and not __fish_seen_subcommand_from $status_commands" -a verbose -d "show verbose firewall status"
complete -c ufw -n "__fish_seen_subcommand_from status; and not __fish_seen_subcommand_from $status_commands" -a numbered -d "show firewall status as numbered list of RULES"

# Default
set -l default_opts_rule allow deny reject
set -l default_opts_target incoming outgoing routed
complete -c ufw -n "__fish_seen_subcommand_from default; and not __fish_seen_subcommand_from $default_opts_rule" -a "$default_opts_rule"
complete -c ufw -n "__fish_seen_subcommand_from default; and __fish_seen_subcommand_from $default_opts_rule; and not __fish_seen_subcommand_from $default_opts_target" -a "$default_opts_target"

# Delete
complete -c ufw -n "__fish_seen_subcommand_from delete; and not __fish_seen_subcommand_from (__fish_ufw_rule)" -a "(__fish_ufw_rule)"
