//
//  EmojiPicker.swift
//  Component
//
//  Created by hhhello0507 on 9/5/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import MCEmojiPicker

struct MCEmojiPickerViewModifier: ViewModifier {
    
    @Binding private var isPresent: Bool
    private let height: CGFloat
    private let action: (_ emoji: String) -> Void
    
    init(
        isPresent: Binding<Bool>,
        height: CGFloat,
        action: @escaping (_ emoji: String) -> Void
    ) {
        self._isPresent = isPresent
        self.height = height
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.sheet(isPresented: $isPresent) {
            MCEmojiPicker(action: action)
                .presentationDetents([.height(height)])
        }
    }
}

public extension View {
    func emojiPicker(_ isPresent: Binding<Bool>, height: CGFloat = 400, action: @escaping (_ emoji: String) -> Void) -> some View {
        self.modifier(MCEmojiPickerViewModifier(isPresent: isPresent, height: height, action: action))
    }
}


struct MCEmojiPicker: UIViewControllerRepresentable {
    
    private let action: (_ emoji: String) -> Void
    
    final class Coordinator: MCEmojiPickerDelegate {
        
        private let action: (_ emoji: String) -> Void
        
        init(action: @escaping (_: String) -> Void) {
            self.action = action
        }
        
        func didGetEmoji(emoji: String) {
            action(emoji)
        }
    }
    
    init(
        action: @escaping (_: String) -> Void
    ) {
        self.action = action
    }
    
    func makeUIViewController(context: Context) -> MCEmojiPickerViewController {
        let viewController = MCEmojiPickerViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: MCEmojiPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
}
