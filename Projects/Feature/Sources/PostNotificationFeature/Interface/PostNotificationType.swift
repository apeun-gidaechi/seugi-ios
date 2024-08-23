//
//  PostNotificationType.swift
//  PostNotificationFeatureInterface
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import Domain

public enum PostNotificationType: Equatable {
    case createNotification
    case updateNotification(Domain.Notification)
}
