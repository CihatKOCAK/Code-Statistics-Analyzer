# Code Statistics Analyzer

## Description
This PowerShell script helps you analyze code statistics within a specified directory. It calculates and presents the total number of files and code lines for each project found in the provided root path. The script supports various file extensions (such as `.html`, `.css`, `.js`, `.ts`, `.jsx`, `.tsx`) and excludes the `node_modules` directory from the count.

In short, the most resources are getting MERN stack friends for now ㋡

## How to Use
1. Make sure you have PowerShell installed on your system.
2. Clone this repository or copy the script code to a local `.ps1` file.

## Running the Script
1. Open PowerShell.
2. Navigate to the directory where you saved the script using the `cd` command.
3. Run the script by entering `.\codeCounter.ps1`.

## Usage
1. The script will prompt you to enter the root directory path. Provide the path to the directory you want to analyze.
2. If the root directory corresponds to a Git repository, the script will show code statistics for that project alone.
3. If the root directory contains multiple projects, the script will display the statistics for each project individually.

**Note:**
- The script counts the number of projects based on the presence of `.git` directories. It only counts projects that are part of a Git repository.
- It won't work properly if you try to count non-git projects.


You can exit the script by pressing 'E' or continue with a new root path by pressing 'N' when prompted.

Feel free to modify and enhance the script to suit your specific needs!
