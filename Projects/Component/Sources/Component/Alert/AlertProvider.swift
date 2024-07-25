import Foundation

public final class AlertProvider: ObservableObject {
    
    public struct Builder {
        let title: String
        let message: String?
        let secondaryButton: AlertButton?
        let primaryButton: AlertButton?
        let provider: AlertProvider
        
        public init(
            title: String,
            provider: AlertProvider
        ) {
            self.title = title
            self.message = nil
            self.secondaryButton = nil
            self.primaryButton = nil
            self.provider = provider
        }
        
        private init(
            title: String,
            message: String?,
            secondaryButton: AlertButton?,
            primaryButton: AlertButton?,
            provider: AlertProvider
        ) {
            self.title = title
            self.message = message
            self.secondaryButton = secondaryButton
            self.primaryButton = primaryButton
            self.provider = provider
        }
        
        public func message(_ message: String?) -> Self {
            .init(title: title, message: message, secondaryButton: secondaryButton, primaryButton: primaryButton, provider: provider)
        }
        
        public func secondaryButton(_ title: String, action: @escaping () -> Void) -> Self {
            .init(title: self.title, message: message, secondaryButton: .init(title, action: action), primaryButton: primaryButton, provider: provider)
        }
        
        public func primaryButton(_ title: String, action: @escaping () -> Void) -> Self {
            .init(title: self.title, message: message, secondaryButton: secondaryButton, primaryButton: .init(title, action: action), provider: provider)
        }
        
        public func show() {
            provider.title = title
            provider.message = message
            provider.secondaryButton = secondaryButton
            provider.primaryButton = primaryButton
            provider.showAlert = true
        }
    }
    
    @Published var showAlert = false
    @Published var title: String = ""
    @Published var message: String?
    @Published var secondaryButton: AlertButton?
    @Published var primaryButton: AlertButton?
    
    public init() {}
    
    public func present(
        _ title: String
    ) -> Builder {
        .init(title: title, provider: self)
    }
}
