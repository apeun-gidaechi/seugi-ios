import Foundation
import SwiftUI

public final class AlertProvider: ObservableObject {
    public struct Alert {
        let title: String
        let message: String?
        let secondaryButton: AlertButton?
        let primaryButton: AlertButton?
        
        public init(
            title: String,
            message: String? = nil,
            secondaryButton: AlertButton? = nil,
            primaryButton: AlertButton? = nil
        ) {
            self.title = title
            self.message = message
            self.secondaryButton = secondaryButton
            self.primaryButton = primaryButton
        }
        
        public func message(_ message: String?) -> Self {
            .init(
                title: self.title,
                message: message,
                secondaryButton: self.secondaryButton,
                primaryButton: self.primaryButton
            )
        }
        
        public func secondaryButton(
            _ title: String,
            action: @escaping () -> Void = {}
        ) -> Self {
            .init(
                title: self.title,
                message: self.message,
                secondaryButton: .init(title, action: action),
                primaryButton: self.primaryButton
            )
        }
        
        public func primaryButton(_ title: String, action: @escaping () -> Void = {}) -> Self {
            .init(
                title: self.title,
                message: self.message,
                secondaryButton: self.secondaryButton,
                primaryButton: .init(title, action: action)
            )
        }
    }
    
    @Published public var isPresent = false
    @Published var alert: Alert?
    
    public init() {}
    
    public func present(
        _ alert: Alert
    ) {
        self.alert = alert
        isPresent = true
    }
}
