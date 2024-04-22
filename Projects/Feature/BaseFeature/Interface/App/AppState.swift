import Foundation
import DesignSystem

public final class AppState: ObservableObject {
    @Published public var appFlow: AppFlow
    @Published public var mainFlow: SeugiBottomNavigationData
    public let googleClientId: String
    
    public init(
        appFlow: AppFlow,
        mainFlow: SeugiBottomNavigationData,
        googleClientId: String
    ) {
        self.appFlow = appFlow
        self.mainFlow = mainFlow
        self.googleClientId = googleClientId
    }
}
