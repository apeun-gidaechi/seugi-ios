import UIKit
import SwiftUI
import AuthenticationServices
import SnapKit

struct AppleSignInLabel: View {
    
    var tapped: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Image(image: .apple)
                .resizable()
                .renderingMode(.template)
                .seugiColor(.sub(.black))
                .frame(width: 18)
            Text("Apple로 계속하기")
                .font(.subtitle(.s2))
                .seugiColor(.sub(.black))
        }
        .onTapGesture {
            tapped()
        }
    }
}

public class AppleVC: UIViewController {
    
    var onSuccess: ((_ token: String) async -> Void)!
    var onFailure: (() async -> Void)!
    var buttonLabel: UIHostingController<AppleSignInLabel>!
    var button: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 12
        b.layer.borderColor = UIColor(Color.seugi(.gray(.g300))).cgColor
        b.layer.borderWidth = 1.5
        return b
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buttonLabel = UIHostingController(rootView: .init {
            self.requestSignIn()
        })
        configureUI()
        setUpLayout()
        setUpAddTarget()
    }
    
    private func configureUI() {
        view.addSubview(button)
        addChild(buttonLabel)
        button.addSubview(buttonLabel.view)
        buttonLabel.didMove(toParent: self)
    }
    
    private func setUpLayout() {
        button.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview()
        }
        buttonLabel.view.snp.makeConstraints {
            $0.center.equalTo(button)
        }
    }
    
    private func setUpAddTarget() {
        button.addTarget(self, action: #selector(requestSignIn), for: .touchUpInside)
    }
    
    @objc
    private func requestSignIn() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension AppleVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        var isFailure = true
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // You can create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
//                print("authorizationCode: \(authorizationCode)")
//                print("identityToken: \(identityToken)")
//                print("authCodeString: \(authCodeString)")
//                print("identifyTokenString: \(identifyTokenString)")
                isFailure = false
                Task {
                    await self.onSuccess(identifyTokenString)
                }
                return
            }
//            print("useridentifier: \(userIdentifier)")
        default:
            break
        }
        if isFailure {
            Task {
                await onFailure()
            }
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("login failed - \(error.localizedDescription)")
    }
}