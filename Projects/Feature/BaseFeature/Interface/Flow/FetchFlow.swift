import SwiftUI

public enum FetchFlow<Data: Equatable>: Equatable {
    case success(_ data: Data)
    case failure
    case fetching
}
