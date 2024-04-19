import Foundation
import DesignSystem

public final class AppState: ObservableObject {
    @Published public var appFlow: AppFlow
    @Published public var mainFlow: SeugiBottomNavigationData
    
    public init(
        appFlow: AppFlow,
        mainFlow: SeugiBottomNavigationData
    ) {
        self.appFlow = appFlow
        self.mainFlow = mainFlow
    }
}
