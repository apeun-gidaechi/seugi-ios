import SwiftUI
import SchoolCodeFeatureInterface

final class SchoolCodeFactoryImpl: SchoolCodeFactory {
    func makeView() -> some View {
        SchoolCodeCoordinator()
    }
}
