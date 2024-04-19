import SwiftUI
import SelectingJobFeature
import BaseFeatureInterface
import DesignSystem

@main
struct SelectingJobViewExample: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            SelectingJobView()
                .environmentObject(Router())
        }
    }
}
