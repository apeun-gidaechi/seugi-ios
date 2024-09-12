//
//  CatSeugiViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 9/12/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import Domain

final class CatSeugiViewModel: BaseViewModel<CatSeugiViewModel.Effect> {
    enum Effect {}
    
    /* message */
    @Published var messages: FetchFlow<[Message]> = .fetching
    @Published var message = ""
}
