import SwiftUI
import WaitingJoinFeatureInterface

final class WaitingJoinFactoryImpl: WaitingJoinFactory {
    func makeView() -> some View {
        WaitingJoinCoordinator()
    }
}
