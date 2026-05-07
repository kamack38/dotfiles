# To install run:
# sudo python -m pip install repl-python-wakatime --target /opt/pwndbg-bin/lib/python3.13/site-packages

try:
    from repl_python_wakatime.backends.wakatime import Wakatime
    from repl_python_wakatime.frontends.gdb import StopHook

    StopHook(Wakatime())
    print("[WakaTime] Plugin loaded successfully.")
except ImportError:
    print(
        "[WakaTime] Error: repl-python-wakatime package not found. Run 'pip install repl-python-wakatime'."
    )
