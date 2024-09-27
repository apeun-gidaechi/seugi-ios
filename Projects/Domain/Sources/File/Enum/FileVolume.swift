//
//  FileVolume.swift
//  Domain
//
//  Created by hhhello0507 on 9/23/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public struct FileEntity: Entity {
    public let size: Double
    public let volume: FileVolume
    
    public init(size: Double, volume: FileVolume) {
        self.size = size
        self.volume = volume
    }
    
    public enum FileVolume: Entity {
        case byte
        case kb
        case mb
        case gb
        case tb
        
        public var text: String {
            switch self {
            case .byte:
                "Byte"
            case .kb:
                "KB"
            case .mb:
                "MB"
            case .gb:
                "GB"
            case .tb:
                "TB"
            }
        }
    }
    
    public static func from(byte: Double) -> Self {
        let fileSizeKB = byte / 1024.0
        let fileSizeMB = fileSizeKB / 1024.0
        let fileSizeGB = fileSizeMB / 1024.0
        let fileSizeTB = fileSizeGB / 1024.0
        
        return if fileSizeTB >= 1 {
            .init(size: fileSizeTB, volume: .tb)
        } else if fileSizeGB >= 1 {
            .init(size: fileSizeGB, volume: .gb)
        } else if fileSizeMB >= 1 {
            .init(size: fileSizeMB, volume: .mb)
        } else if fileSizeKB >= 1 {
            .init(size: fileSizeKB, volume: .kb)
        } else {
            .init(size: byte, volume: .byte)
        }
    }
}
