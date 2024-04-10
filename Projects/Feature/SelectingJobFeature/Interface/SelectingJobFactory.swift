import SwiftUI

public protocol SelectingJobFactory {
    associatedtype ViewType
    func makeView() -> ViewType
}
