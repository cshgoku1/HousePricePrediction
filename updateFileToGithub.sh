#!/bin/bash

# Check if a file path is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: ./updateFileToGithub.sh <path_to_new_csv_file>"
    exit 1
fi

# Variables
REPO_URL="https://github.com/shruthic318/HousePricePrediction_Webscraping.git"  # Replace with your GitHub repo URL
CSV_FILE="Cleaned_HousePrice.csv"  # File to be updated
NEW_FILE_PATH=$1  # Path to the new CSV file
BRANCH="shruthic318-patch-1"  # Branch to push to (default: main)

# Clone the repository (shallow clone for the branch)
echo "Cloning the repository..."
git clone --depth 1 --branch $BRANCH $REPO_URL repo-temp

# Navigate to the repository
cd repo-temp || exit

# Replace the old CSV file with the new one
echo "Replacing the old CSV file with the new one..."
cp "$NEW_FILE_PATH" "Dataset/$CSV_FILE"

# Commit and push the changes
echo "Committing and pushing the changes to GitHub..."
git add "Dataset/$CSV_FILE"
git commit -m "Updated Cleaned_HousePrice.csv with new data"
git push origin $BRANCH

# Clean up
echo "Cleaning up..."
cd ..
rm -rf repo-temp

echo "File updated successfully!"
