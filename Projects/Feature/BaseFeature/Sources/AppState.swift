import Foundation

public final class AppState: ObservableObject {
    @Published var appFlow: AuthType
    
    init(
        appFlow: AuthType
    ) {
        self.appFlow = appFlow
    }
}
