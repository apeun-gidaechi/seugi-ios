//
//  ArrayUtil.swift
//  SwiftUtil
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public enum ArrayUtil {
    public static func splitArray<T>(array: [T]) -> [[T]] {
        let middleIndex: Int = Int(ceil(Double(array.count) / 2.0))
        let firstHalf = Array(array[0..<middleIndex])
        let secondHalf = Array(array[middleIndex..<array.count])
        return [firstHalf, secondHalf]
    }
}
