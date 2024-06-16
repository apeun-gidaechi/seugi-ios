import SwiftUI

public struct SeugiAppleSignInButton: UIViewControllerRepresentable {
    
    private let onSuccess: (_ token: String) -> Void
    private let onFailure: () -> Void
    
    public init(
        onSuccess: @escaping (_: String) -> Void,
        onFailure: @escaping () -> Void
    ) {
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
    
    public func makeUIViewController(context: Context) -> AppleVC {
        let appleVC = AppleVC()
        appleVC.onSuccess = onSuccess
        appleVC.onFailure = onFailure
        return appleVC
    }
    
    public func updateUIViewController(_ uiViewController: AppleVC, context: Context) {
        //
    }
}
