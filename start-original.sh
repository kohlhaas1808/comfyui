#!/bin/bash

# You can make modifications to this file if you want to customize the startup process.
# Things like installing additional custom nodes, or downloading models can be done here.


# Disable Mixlab nodes because they take a long time load and are no longer needed in any of the included workflows.
# But can be enabled if needed by commenting out the following line.

# Launch the UI
python3 /ComfyUI/main.py --listen

# Keep the container running indefinitely
sleep infinity
