import DesignSystem
import Foundation
import DIContainerInterface
import AuthDomainInterface

public class EmailSignUpViewModel: ObservableObject {
    
    // MARK: - State
    @Published var name = "1"
    @Published var email = "hhhello0507@gmail.com"
    @Published var password = "1"
    @Published var passwordCheck = "1"
    
    var isInValidInput: Bool {
        name.isEmpty || email.isEmpty || password.isEmpty || passwordCheck.isEmpty || password != passwordCheck
    }
    
    public init() {}
}
