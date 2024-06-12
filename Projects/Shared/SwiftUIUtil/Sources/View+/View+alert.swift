import SwiftUI

public extension View {
    func alertWithAnyView<A>(_ titleKey: LocalizedStringKey, when: Binding<Bool>, @ViewBuilder actions: () -> A) -> some View where A : View {
        self
            .eraseToAnyView()
            .alert(titleKey, isPresented: when, actions: actions)
    }
    
    func alertWithAnyView<A, M>(_ titleKey: LocalizedStringKey, when: Binding<Bool>, @ViewBuilder actions: () -> A, @ViewBuilder message: () -> M) -> some View where A : View, M : View {
        self
            .eraseToAnyView()
            .alert(titleKey, isPresented: when, actions: actions, message: message)
    }
}
