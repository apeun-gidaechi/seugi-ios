sudo rm -rf ~/Library/Developer/Xcode/DerivedData
sudo rm -rf **/*.xcodeproj
sudo rm -rf *.xcworkspace

# clean swift package
rm -rf ~/Library/Caches/org.swift.swiftpm
rm -rf ~/Library/org.swift.swiftpm

rm -rf ./Tuist/Dependencies

mise exec -- tuist clean
