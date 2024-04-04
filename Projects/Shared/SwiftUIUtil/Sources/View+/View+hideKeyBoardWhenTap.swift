//
//  View+hideKeyBoardWhenTap.swift
//  SwiftUIUtil
//
//  Created by dgsw8th71 on 4/4/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public extension View {
    func hideKeyboardWhenTap() -> some View {
        onAppear(perform: UIApplication.shared.hideKeyboard)
    }
}

extension UIApplication {
    func hideKeyboard() {
        guard let scene = connectedScenes.first as? UIWindowScene,
                      let window = scene.windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return false
    }
}
