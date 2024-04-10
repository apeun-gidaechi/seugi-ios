import SwiftUI

public protocol MainFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
