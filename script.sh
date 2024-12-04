#!/bin/bash

echo "You must first connect to the VPN of TEQNOLOGICAL ASIA."

# Check if gitleaks is already installed
if command -v gitleaks &> /dev/null; then
  echo "gitleaks is already installed."
  gitleaks --version
  exit 0
fi

echo "Start Install ......."

# URL of the zip file
url="https://git.teqnological.asia/kietdo/teq-gitleak/-/jobs/artifacts/v1.0.5/download?job=build"

# Download the zip file
curl -L $url -o artifacts.zip

# Check if the download was successful
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to download the file."
  exit 1
fi

# Verify the file format
file_type=$(file --mime-type -b artifacts.zip)
echo "File type: $file_type"
if [[ $file_type != "application/zip" ]]; then
  echo "Error: The downloaded file is not a valid zip archive."
  rm artifacts.zip
  exit 1
fi

# Extract the zip file
unzip artifacts.zip

# Check if the extraction was successful
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to extract the zip file."
  rm artifacts.zip
  exit 1
fi

# Move the binary to /usr/local/bin/
sudo mv gitleaks /usr/local/bin/

# Check if the move was successful
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to move the binary to /usr/local/bin/."
  rm -rf artifacts.zip gitleaks
  exit 1
fi

# Clean up
rm -rf artifacts.zip gitleaks

# Verify the installation
gitleaks --version

# Check if the command was successful
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to verify the installation."
  exit 1
fi

echo "Installation completed successfully."