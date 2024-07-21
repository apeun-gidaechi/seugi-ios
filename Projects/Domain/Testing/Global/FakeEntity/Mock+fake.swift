import Domain
import Combine
import Foundation

extension Entity {
    var successResult: APIResult<Self> {
        Just(.fetching)
            .append(Just(.success(self)).delay(for: .seconds(1), scheduler: DispatchQueue.main))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    var successBaseResult: APIResult<Base<Self>> {
        Just(.fetching)
            .append(Just(.success(withFakeBase())).delay(for: .seconds(1), scheduler: DispatchQueue.main))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
