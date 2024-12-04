#!/bin/bash

# Check if gitleaks is installed
if command -v gitleaks &> /dev/null; then
  echo "Removing gitleaks from /usr/local/bin/"

  # Remove the gitleaks binary
  sudo rm /usr/local/bin/gitleaks

  # Check if the removal was successful
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to remove gitleaks."
    exit 1
  fi

  echo "gitleaks has been removed successfully."
else
  echo "gitleaks is not installed."
fi