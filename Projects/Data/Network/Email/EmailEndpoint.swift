import Moya

enum EmailEndpoint {
    case send(email: String)
}

extension EmailEndpoint: SeugiEndpoint {
    var host: String { "email" }
    var route: Route {
        switch self {
        case .send(let email):
            .get("send")
            .task(["email": email].toURLParameters())
        }
    }
}
