import SwiftUI

public protocol JoinSchoolFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
