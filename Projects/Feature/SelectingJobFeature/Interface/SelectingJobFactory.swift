import SwiftUI

public protocol SelectingJobFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
