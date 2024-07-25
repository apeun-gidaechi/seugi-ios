//
//  ModalViewProtocol.swift
//  Component
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

protocol ModalViewProtocol: View {
    associatedtype P: ModalProvider
    associatedtype C: View
    
    var content: () -> C { get }
    
    func dismiss()
}
