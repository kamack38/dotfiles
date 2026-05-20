complete -c fundump -f
complete -c fundump -n "__fish_is_nth_token 1" -F

function __fundump_parse_binary
    set -l cmd (commandline -opc)
    set -l file $cmd[2]

    if test -f "$file"
        objdump -t $file 2>/dev/null | awk '$0 ~ / F \./ {print $NF}'
    end
end

complete -c fundump -n "__fish_is_nth_token 2" -a "(__fundump_parse_binary)" --description Function
