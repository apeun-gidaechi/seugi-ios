import Foundation
import DesignSystem

public final class AppState: ObservableObject {
    @Published public var appFlow: AppFlow
    @Published public var mainFlow: SeugiBottomNavigationType
    
    public init(
        appFlow: AppFlow,
        mainFlow: SeugiBottomNavigationType
    ) {
        self.appFlow = appFlow
        self.mainFlow = mainFlow
    }
}
