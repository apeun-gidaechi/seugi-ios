echo "Improve Build..."
defaults write com.apple.dt.XCBuild EnableSwiftBuildSystemIntegration 8
defaults write com.apple.dt.Xcode BuildSystemScheduleInherentlyParallelCommandsExclusively -bool YES
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES
defaults write com.apple.Xcode PBXNumberOfParallelBuildSubtasks 8
echo "Improve Build... Finish!"
