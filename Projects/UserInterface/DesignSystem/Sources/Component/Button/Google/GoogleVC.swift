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

public class GoogleVC: UIViewController {
    
    private var clientId: String!
    var buttonLabel: UIHostingController<GoogleSignInLabel>!
    var button: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 12
        b.layer.borderColor = UIColor(Color.seugi(.gray(.g300))).cgColor
        b.layer.borderWidth = 1.5
        return b
    }()
    
    func setClientId(_ str: String) {
        self.clientId = str
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buttonLabel = UIHostingController(rootView: .init {
            //
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
        let signInConfig = GIDConfiguration(clientID: clientId)
        print("\(#function) - try google sign in")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user else { return }
            
            let email = user.profile?.email
            let name = user.profile?.name
            
            // 1. do를 통해 가져오기
            user.authentication.do { authentication, error in
                guard let authentication = authentication else { return }
                let idToken       = authentication.idToken
                let accessToken   = authentication.accessToken
                let refreshToken  = authentication.refreshToken
                let clientID      = authentication.clientID
            }
            
            // 2. authentication에서 바로 가져오기
            let idToken       = user.authentication.idToken
            let accessToken   = user.authentication.accessToken
            let refreshToken  = user.authentication.refreshToken
            let clientID      = user.authentication.clientID
            print(accessToken)
        }
    }
}
