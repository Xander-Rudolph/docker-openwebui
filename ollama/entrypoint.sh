#!/bin/bash

# Got this process from RafaelRS 

# Start Ollama in the background.
/bin/ollama serve &
# Record Process ID.
pid=$!

# Pause for Ollama to start.
sleep 5

echo "Retrieve $DEFAULT_MODEL model..."
ollama pull $DEFAULT_MODEL
echo "Done!"

# Wait for Ollama process to finish.
wait $pid