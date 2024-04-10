import SwiftUI

public protocol StartFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
