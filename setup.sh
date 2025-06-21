#!/bin/bash

echo "🚀 Setting up Run iOS App..."

# Initialize git repository
git init

# Add all files
git add .

# Make initial commit
git commit -m "Initial commit: Flutter iOS app with client ID input"

# Add remote repository
git remote add origin https://github.com/srujan5570/run-ios.git

# Push to main branch
git branch -M main
git push -u origin main

echo "✅ Setup complete! Your Flutter iOS app has been pushed to GitHub."
echo "📱 To build the IPA file:"
echo "   1. Go to https://github.com/srujan5570/run-ios/actions"
echo "   2. Click on 'iOS-ipa-build' workflow"
echo "   3. Click 'Run workflow'"
echo "   4. Wait for the build to complete"
echo "   5. Download the IPA file from the releases section" 