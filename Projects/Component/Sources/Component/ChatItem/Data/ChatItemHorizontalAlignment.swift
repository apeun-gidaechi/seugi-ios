//
//  ChatItemHorizontalAlignment.swift
//  Component
//
//  Created by hhhello0507 on 9/23/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import SwiftUI

public enum ChatItemHorizontalAlignment: RawRepresentable {
    public init?(rawValue: HorizontalAlignment) {
        switch rawValue {
        case .leading: self = .leading
        case .trailing: self = .trailing
        default:
            return nil
        }
    }
    
    case leading
    case trailing
    
    public var rawValue: HorizontalAlignment {
        switch self {
        case .leading:
                .leading
        case .trailing:
                .trailing
        }
    }
}
