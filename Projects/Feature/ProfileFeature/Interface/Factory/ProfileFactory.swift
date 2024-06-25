import SwiftUI

public protocol ProfileFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
