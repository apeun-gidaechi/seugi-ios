import SwiftUI

public protocol SettingProfileFactory {
    associatedtype ViewType: View
    func makeView() -> ViewType
}
