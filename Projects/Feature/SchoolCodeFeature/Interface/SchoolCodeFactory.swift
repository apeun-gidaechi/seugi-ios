import SwiftUI

public protocol SchoolCodeFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
