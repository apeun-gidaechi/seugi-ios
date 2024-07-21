import SwiftUI
import BaseFeatureInterface
import DIContainer
import SwiftUIUtil

public struct JoinSchoolCoordinator: View {
    
    @EnvironmentObject private var router: Router
    @StateObject private var joinSchoolViewModel: JoinSchoolViewModel = .init()
    
    public init() {}
    
    public var body: some View {
        SchoolCodeView()
            .environmentObject(joinSchoolViewModel)
    }
}
