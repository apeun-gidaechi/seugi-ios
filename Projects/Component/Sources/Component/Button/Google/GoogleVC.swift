import UIKit
import SwiftUI
import AuthenticationServices
import SnapKit
import GoogleSignIn

struct GoogleSignInLabel: View {
    
    var tapped: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Image(image: .google)
                .resizable()
                .frame(width: 20)
            Text("Google로 계속하기")
                .font(.subtitle(.s2))
                .seugiColor(.sub(.black))
        }
        .onTapGesture {
            tapped()
        }
    }
}

public final class GoogleVC: UIViewController {
    
    var onSuccess: ((_ idToken: String) -> Void)!
    var onFailure: (() -> Void)!
    var buttonLabel: UIHostingController<GoogleSignInLabel>!
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
            self.googleSignIn()
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
        button.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
    }
    
    @objc
    private func googleSignIn() {
        let clientId = Bundle.main.object(forInfoDictionaryKey: "GoogleClientId") as? String ?? ""
        let signInConfig = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil, 
                    let user else {
                return
            }
            
            let idToken = user.authentication.idToken
            self.onSuccess(idToken ?? "")
        }
    }
}
