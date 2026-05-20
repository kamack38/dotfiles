function fundump -a file fun --description "Show disassembly of a function"
    objdump --disassemble=$fun --section=.text $file
end

function lend -a str --description "Change endianess"
    echo $str | tac -rs '..' | tr -d '\n'
end
