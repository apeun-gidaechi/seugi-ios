import SwiftUI

public protocol SettingProfileFactory {
    associatedtype ContentView: View
    func makeView() -> ContentView
}
