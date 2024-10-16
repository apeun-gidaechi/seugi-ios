import Moya

/// Route
/// Moya.TargetType에서 method, path, task를 추상화 한 struct
///
/// Ex.
/// Route.get()
/// Route.get("hello")
/// Route.get("hello").task(.requestJSONEncodable(...))
public struct Route {
    let method: Moya.Method
    let path: String
    let task: Moya.Task
    
    private init(method: Moya.Method, path: String, task: Moya.Task) {
        self.method = method
        self.path = path
        self.task = task
    }
    
    static func connect(_ path: String) -> Self {
        Self.init(method: .connect, path: path, task: .requestPlain)
    }
    
    static func delete(_ path: String = "") -> Self {
        Self.init(method: .delete, path: path, task: .requestPlain)
    }
    
    static func get(_ path: String = "") -> Self {
        Self.init(method: .get, path: path, task: .requestPlain)
    }
    
    static func head(_ path: String = "") -> Self {
        Self.init(method: .head, path: path, task: .requestPlain)
    }
    
    static func options(_ path: String = "") -> Self {
        Self.init(method: .options, path: path, task: .requestPlain)
    }

    static func patch(_ path: String = "") -> Self {
        Self.init(method: .patch, path: path, task: .requestPlain)
    }
    
    static func post(_ path: String = "") -> Self {
        Self.init(method: .post, path: path, task: .requestPlain)
    }
    
    static func put(_ path: String = "") -> Self {
        Self.init(method: .put, path: path, task: .requestPlain)
    }
    
    static func query(_ path: String = "") -> Self {
        Self.init(method: .query, path: path, task: .requestPlain)
    }
    
    static func trace(_ path: String = "") -> Self {
        Self.init(method: .trace, path: path, task: .requestPlain)
    }

    func task(_ task: Moya.Task) -> Self {
        Self.init(method: method, path: path, task: task)
    }
}
