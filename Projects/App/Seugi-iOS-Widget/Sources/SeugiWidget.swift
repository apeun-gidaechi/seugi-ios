import Foundation
import WidgetKit
import SwiftUI
import DIContainer
import Component

@main
struct AppMainWidget: WidgetBundle {
    
    init() {
        DependencyProvider.shared.register()
    }
    
    var body: some Widget {
        MealWidget()
    }
}
