import UIKit
import SwiftUI
import AuthenticationServices
import SnapKit

struct GoogleSignInLabel: View {
    
    var tapped: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Image(image: .google)
                .resizable()
                .renderingMode(.template)
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
            //
        })
        configureUI()
        setUpLayout()
        setUpAddTarget()
    }
    
    private func configureUI() {
        view.addSubview(button)
        button.addSubview(buttonLabel.view)
    }
    
    private func setUpLayout() {
        view.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        button.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        buttonLabel.view.snp.makeConstraints {
            $0.center.equalTo(button)
        }
    }
    
    private func setUpAddTarget() {
    }
}
