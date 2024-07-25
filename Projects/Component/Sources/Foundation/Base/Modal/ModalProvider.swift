//
//  ModalProvider.swift
//  Component
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation

protocol ModalProvider: ObservableObject {
    var isPresent: Bool { get }
}
