//
//  DateFormmater+.swift
//  DateUtil
//
//  Created by hhhello0507 on 7/24/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation

public extension DateFormatter {
    convenience init(_ dateFormat: String, locale: Locale = Locale(identifier: "ko_KR")) {
        self.init()
        self.dateFormat = dateFormat
        self.locale = locale
    }
}
