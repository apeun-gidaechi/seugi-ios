import UIKit
import SwiftUI
import AuthenticationServices
import SnapKit
import SwiftUIUtil

public struct GoogleLoginButton: View {
    
    private let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                Image(image: .google)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Google로 계속하기")
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
            }
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .seugiBackground(.sub(.white))
            .cornerRadius(8, corners: .allCorners)
            .stroke(8, content: Color(0xFFE6E6E6))
        }
        .applyAnimation()
    }
}
