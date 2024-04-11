import SwiftUI

public struct SeugiAppleSignInButton: UIViewControllerRepresentable {
    
    public init() {}
    
    public func makeUIViewController(context: Context) -> AppleVC {
        let appleVC = AppleVC()
        return appleVC
    }
    
    public func updateUIViewController(_ uiViewController: AppleVC, context: Context) {
        //
    }
}
