import Foundation

public final class TimePickerProvider: ObservableObject {
    @Published var isPresent = false
    @Published var title: String?
    @Published var action: (() -> Void)?
    
    public init() {}
    
    public func present(
        _ title: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
        isPresent = true
    }
}
