public struct AlertButton {
    let title: String
    let action: () -> Void
    
    public init(
        _ title: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
    }
}
