import SwiftUI
import DIContainer
import Component

public struct ProfileCoordinator: View {
    
    public var body: some View {
        ProfileView()
            .navigationDestination(for: ProfileDestination.self) {
                switch $0 {
                case .settingProfile: SettingProfileCoordinator()
                }
            }
    }
}
