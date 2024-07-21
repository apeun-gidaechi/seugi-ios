import SwiftUI
import BaseFeatureInterface
import DIContainer
import SwiftUIUtil
import JoinSchoolFeatureInterface

public struct JoinSchoolCoordinator: View {
    
    @EnvironmentObject private var router: Router
    @StateObject private var joinSchoolViewModel = JoinSchoolViewModel()
    
    public init() {}
    
    public var body: some View {
        SchoolCodeView()
            .environmentObject(joinSchoolViewModel)
            .navigationDestination(for: JoinSchoolDestination.self) { destination in
                Group {
                    switch destination {
                    case .waitingJoin: WaitingJoinView()
                    case .joinSuccess: JoinSuccessView()
                    }
                }
                .environmentObject(joinSchoolViewModel)
            }
    }
}
