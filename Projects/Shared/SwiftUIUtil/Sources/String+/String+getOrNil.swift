//
//  String+.swift
//  SwiftUIUtil
//
//  Created by dgsw8th71 on 4/3/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation

public extension String {
    func getOrNil(idx: Int) -> String? {
        let strLength = self.count
        guard strLength > idx else {
            return nil
        }
        let endIndex = self.index(self.startIndex, offsetBy: idx)
        let substring = self[endIndex...endIndex]
        return String(substring)
    }
}
