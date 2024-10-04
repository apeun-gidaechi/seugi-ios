import Combine

public typealias APIResult<Output> = AnyPublisher<Output, APIError>
