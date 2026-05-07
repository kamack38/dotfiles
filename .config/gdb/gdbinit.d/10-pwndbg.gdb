python
import gdb

# Global variable to store our active stop event listener
_active_stop_handler = None

class LinkTtyCommand(gdb.Command):
    """Link nearpc 100 disassembly output to a secondary TTY.
    Usage: link-tty <tty_number> (e.g., link-tty 4)"""
    
    def __init__(self):
        super(LinkTtyCommand, self).__init__("link-tty", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        global _active_stop_handler
        
        args = gdb.string_to_argv(arg)
        if not args:
            print("Error: Please specify a TTY number (e.g., link-tty 4)")
            return
            
        tty_path = f"/dev/pts/{args[0]}"
        print(f"[*] Linking disassembly output to {tty_path}...")

        # 1. Safely disconnect any previously registered hook to avoid duplicate loops
        if _active_stop_handler is not None:
            try:
                gdb.events.stop.disconnect(_active_stop_handler)
            except Exception:
                pass

        # 2. Define the new hook function bound to this specific TTY path
        def on_stop(event):
            try:
                # Clear target terminal
                gdb.execute(f"shell clear > {tty_path}")
                # Fetch nearpc 100 output and write it to the TTY
                disasm_output = gdb.execute("nearpc 100", to_string=True)
                with open(tty_path, "w") as f:
                    f.write(disasm_output)
            except Exception as e:
                # Silently catch writing issues if target terminal closes/fails
                pass

        # 3. Register the hook and save a reference to it
        gdb.events.stop.connect(on_stop)
        _active_stop_handler = on_stop
        print(f"[+] Hook active! Run your program or step to see output.")

# Instantiate the command in GDB
LinkTtyCommand()
end

set show-tips off
