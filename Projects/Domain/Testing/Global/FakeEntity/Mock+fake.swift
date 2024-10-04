import Domain
import Combine
import Foundation

extension Entity {
    var successResult: APIResult<Self> {
        Future { completion in
            completion(.success(self))
        }
        .delay(for: .seconds(1), scheduler: DispatchQueue.main)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
        .observe()
    }
    
    var successBaseResult: APIResult<Base<Self>> {
        Future { completion in
            completion(.success(self.withFakeBase()))
        }
        .delay(for: .seconds(1), scheduler: DispatchQueue.main)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
        .observe()
    }
}
