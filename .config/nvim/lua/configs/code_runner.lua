return {
  filetype = {
    c =
    'cd "$dir" && mkdir -p "$dir/bin" && gcc "$dir/$fileName" -o "$dir/bin/$fileNameWithoutExt" -std=c11 -Wall -Wextra -fsanitize=address,undefined && "$dir/bin/$fileNameWithoutExt"',
    cpp = function()
      if vim.fn.has "win32" == 1 then
        return
        'cd "$dir" && mkdir -p "$dir/bin" -Force > $null && g++ "$dir\\$fileName" -std=c++11 -o "$dir\\bin\\$fileNameWithoutExt.exe" && & "$dir\\bin\\$fileNameWithoutExt.exe"'
      else
        return
        'cd "$dir" && mkdir -p "$dir/bin" && g++ "$dir/$fileName" -o "$dir/bin/$fileNameWithoutExt" -std=c++11 -fsanitize=address,undefined && "$dir/bin/$fileNameWithoutExt"'
      end
    end,
    tex = 'mkdir -p "$dir/bin" && pdflatex -output-directory="$dir/bin" "$dir/$fileName"',
    rust = 'cargo run "$dir/$fileName"',
    ocaml = 'ocaml $dir/$fileName'
  },
  startinsert = true,
}
