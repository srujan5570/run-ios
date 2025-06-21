#!/bin/bash

set -e

echo "🚀 Starting iOS build process..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
rm -rf ios/Pods ios/Podfile.lock ios/.symlinks
rm -rf ios/Flutter/Flutter.framework
rm -rf ios/Flutter/Flutter.podspec

# Get dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get

# Install iOS dependencies
echo "📱 Installing iOS dependencies..."
cd ios
pod install --repo-update --verbose
cd ..

# Build iOS app with minimal configuration
echo "🔨 Building iOS app..."
flutter build ios \
  --release \
  --no-codesign \
  --verbose \
  --build-number=1 \
  --build-name=1.0.0

# Alternative build approach if the above fails
if [ ! -d "build/ios/iphoneos/Runner.app" ]; then
    echo "⚠️  First build approach failed, trying alternative..."
    flutter build ios --release --no-codesign --verbose
fi

# Verify build output
echo "✅ Verifying build output..."
if [ -d "build/ios/iphoneos/Runner.app" ]; then
    echo "✅ Runner.app found successfully"
    ls -la build/ios/iphoneos/
else
    echo "❌ Runner.app not found"
    echo "Checking build directory contents:"
    ls -la build/ios/iphoneos/ || echo "Build directory doesn't exist"
    echo "Checking all build directories:"
    find build -name "*.app" -type d 2>/dev/null || echo "No .app directories found"
    exit 1
fi

# Create IPA
echo "📦 Creating IPA file..."
mkdir -p build/ios/iphoneos/Payload
mv build/ios/iphoneos/Runner.app build/ios/iphoneos/Payload/
cd build/ios/iphoneos
zip -qq -r -9 FlutterIpaExport.ipa Payload
cd ../../..

# Verify IPA
echo "✅ Verifying IPA file..."
if [ -f "build/ios/iphoneos/FlutterIpaExport.ipa" ]; then
    echo "✅ IPA file created successfully"
    ls -lh build/ios/iphoneos/FlutterIpaExport.ipa
else
    echo "❌ IPA file not found"
    exit 1
fi

echo "🎉 iOS build completed successfully!" 