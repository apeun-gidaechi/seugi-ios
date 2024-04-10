import Foundation

public final class AppState: ObservableObject {
    @Published var appFlow: AppFlow
    
    init(
        appFlow: AppFlow
    ) {
        self.appFlow = appFlow
    }
}
