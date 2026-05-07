python
def print_register_matrix(reg_name):
    # Retrieve the register value and mask it to force a clean, unsigned 64-bit int
    raw_val = gdb.parse_and_eval(f"${reg_name}")
    val = int(raw_val) & 0xffffffffffffffff

    # Format as a 64-character binary string with leading zeros
    bin_str = f"{val:064b}"

    print(f"\n--- 8x8 Bit Matrix for %{reg_name} ---")
    # Slice the string into 8-bit rows and print from top to bottom
    for i in range(0, 64, 8):
        row = bin_str[i:i+8]
        print(" ".join(row))
    print("-----------------------------------\n")

class PrintMatrix(gdb.Command):
    def __init__(self):
        super(PrintMatrix, self).__init__("print_matrix", gdb.COMMAND_USER)
    def invoke(self, arg, from_tty):
        if not arg:
            print("Please specify a register (e.g., rdi)")
            return
        try:
            print_register_matrix(arg.strip("$%"))
        except Exception as e:
            print(f"Error: {e}")

PrintMatrix()
end

set debuginfod enabled on
set disassembly-flavor att
set confirm off
set history save
set history filename ~/.local/state/gdb/gdb_history
set verbose off
set print pretty on
set print array off
set print array-indexes on
set python print-stack full
