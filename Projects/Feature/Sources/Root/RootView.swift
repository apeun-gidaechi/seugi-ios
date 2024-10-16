import SwiftUI
import Domain

public struct RootView: View {
    @StateObject private var appState = AppViewModel()
    @StateObject private var router = RouterViewModel()
    @StateObject private var keyboardMonitor = KeyboardMonitor()
    @AppStorage("ACCESS_TOKEN", store: .seugi) var accessToken: String?
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            if accessToken == nil {
                OnboardingCoordinator()
            } else {
                MainCoordinator()
            }
        }
        .launchScreen {
            LaunchScreenView()
        }
        .environmentObject(keyboardMonitor)
        .environmentObject(router)
        .environmentObject(appState)
    }
}
