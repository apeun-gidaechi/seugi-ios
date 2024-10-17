//  Author: hhhello0507
//  Created: 10/10/24


import Foundation
import SwiftUI
import Component

extension View {
    @ViewBuilder
    nonisolated public func safeContainerBackground(
        alignment: Alignment = .center,
        color: Color.SeugiColorSystem
    ) -> some View {
        if #available(iOS 17.0, iOSApplicationExtension 17.0, *) {
            self.containerBackground(for: .widget) {
                Color.seugi(color)
            }
        } else {
            self
        }
    }
}
