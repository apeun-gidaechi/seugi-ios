import Foundation

import Moya

// NetRunner 클래스에서 사용.
// 원래 NetRunner는 BaseEndpoint를 준수 받는 Endpoint (e.g. MealEndpoint, AIEndpoint)를 Generic하게 사용하고 있었음.
// 이런 방식으로 하니 각 Endpoint 별로 NetRunner를 만들어야 함.
//
// 이 프로젝트에서는 각 Endpoint 별로 다른 NetRunner를 쓸 필요성을 못 느낌.
// 따라서 NetRunner는 Generic하게 사용하는 오브젝트를 알 필요가 없음.
//
// 결론적으로 NetRunner가 특정 Endpoint를 알지 못하게 하기 위해 한 단계 더 고수준의 enum인 AnyEndpoint를 도입함.
//
// 🔽 아래 깃헙 참고해서 구현함 🔽
// https://github.com/GSM-MSG/Emdpoint/blob/master/Sources/Emdpoint/EndpointType/EndpointType.swift
// https://github.com/Team-Ampersand/Dotori-iOS/blob/master/Projects/Core/Networking/Sources/NetworkingImpl.swift
public enum AnyEndpoint {
    case endpoint(any BaseEndpoint)
    var endpoint: any BaseEndpoint {
        switch self {
        case .endpoint(let endpoint):
            return endpoint
        }
    }
    
    public init(_ endpoint: BaseEndpoint) {
        self = .endpoint(endpoint)
    }
}

extension AnyEndpoint: BaseEndpoint {
    public var host: String { endpoint.host }
    public var route: Route { endpoint.route }
    public var baseURL: URL { endpoint.baseURL }
}
