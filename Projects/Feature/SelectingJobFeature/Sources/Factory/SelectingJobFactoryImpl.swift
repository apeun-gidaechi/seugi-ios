import SwiftUI
import SelectingJobFeatureInterface

final class SelectingJobFactoryImpl: SelectingJobFactory {
    func makeView() -> some View {
        SelectingJobCoordinator()
    }
}
