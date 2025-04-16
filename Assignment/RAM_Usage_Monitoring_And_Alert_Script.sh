#!/bin/bash

# Set the RAM usage threshold
THRESHOLD=80

# Run monitoring loop
while true; do
  # Get the current RAM usage percentage
  usage=$(free | awk '/Mem/ { printf("%.0f"), $3/$2 * 100 }')

  # Check if usage exceeds threshold
  if [ "$usage" -ge "$THRESHOLD" ]; then
    # Send high usage notification
    notify-send "⚠️ High RAM Usage" "Current usage: $usage%.\nCheck for resource-hungry processes!"
    echo "ALERT: High RAM usage detected: ${usage}%"
  else
    # Send normal usage message (optional)
    echo "RAM usage is normal: ${usage}%"
  fi


  sleep 10
done

