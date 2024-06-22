import Domain
import Combine
import Foundation

extension Entity {
    var successResult: APIResult<Self> {
        [.success(self)].publisher
            .receive(on: DispatchQueue.main)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    var successBaseResult: APIResult<Base<Self>> {
        [.success(self.withFakeBase())].publisher
            .receive(on: DispatchQueue.main)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
