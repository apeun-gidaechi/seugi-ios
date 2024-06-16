import Component
import Foundation
import DIContainer
import Domain

public class EmailSignUpViewModel: ObservableObject {
    
    // MARK: - State
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordCheck = ""
    
    var isInValidInput: Bool {
        name.isEmpty || email.isEmpty || password.isEmpty || passwordCheck.isEmpty || password != passwordCheck
    }
    
    public init() {}
}
