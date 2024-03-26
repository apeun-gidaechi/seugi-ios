import DesignSystem
import SwiftUI
import Feature

@main
struct SeugiApp: App {
    
    @StateObject var navController = NavigationController()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navController.path) {
                StartView()
                    .navigationDestination(for: ViewType.self) { viewType in
                        switch viewType {
                        case .start: StartView()
                        case .emailSignIn: EmailSignInView()
                        }
                    }
            }
            .environmentObject(navController)
        }
    }
}

#Preview {
    EmailSignInView()
}
