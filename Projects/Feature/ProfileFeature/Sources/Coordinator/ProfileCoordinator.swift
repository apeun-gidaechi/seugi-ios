import SwiftUI
import ProfileFeatureInterface
import SettingProfileFeatureInterface
import DIContainer
import Component

public struct ProfileCoordinator: View {
    
    @Inject private var settingProfileFactory: any SettingProfileFactory
    
    public var body: some View {
        ProfileView()
            .navigationDestination(for: ProfileDestination.self) {
                switch $0 {
                case .settingProfile: settingProfileFactory.makeView().eraseToAnyView()
                }
            }
    }
}
