import SwiftUI
import Component
import Swinject
import DIContainer
import SwiftUIUtil
import Feature

@main
struct SeugiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var alertProvider = AlertProvider()
    @StateObject private var timePickerProvider = TimePickerProvider()
    
    init() {
        Pretendard.register()
        DependencyProvider.shared.register()
    }
    
    var body: some Scene {
        WindowGroup {
            SeugiModalProvider(
                alertProvider: alertProvider,
                timePickerProvider: timePickerProvider
            ) {
                RootView()
            }
        }
    }
}
