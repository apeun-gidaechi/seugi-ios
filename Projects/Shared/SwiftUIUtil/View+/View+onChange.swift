//
//  View+onChange.swift
//  SwiftUIUtil
//
//  Created by hhhello0507 on 9/15/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI

public extension View {
    @inlinable
    @ViewBuilder
    func onChange<V>(of value: V, initial: Bool, action: @escaping (_ newValue: V) -> Void) -> some View where V: Equatable {
        if initial {
            self.onChange(of: value, perform: action).onAppear { action(value) }
        } else {
            self.onChange(of: value, perform: action)
        }
    }
}
