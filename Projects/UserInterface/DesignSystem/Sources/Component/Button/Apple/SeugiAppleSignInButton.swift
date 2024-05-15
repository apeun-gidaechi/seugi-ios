import SwiftUI

public struct SeugiAppleSignInButton: UIViewControllerRepresentable {
    
    private let onSuccess: (_ token: String) async -> Void
    private let onFailure: () async -> Void
    
    public init(
        onSuccess: @escaping (_: String) async -> Void,
        onFailure: @escaping () async -> Void
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
