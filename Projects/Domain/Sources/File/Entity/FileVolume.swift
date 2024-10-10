public enum FileVolume: Entity {
    case byte
    case kilobyte
    case megabyte
    case gigabyte
    case terabyte
    
    public var text: String {
        switch self {
        case .byte:
            "Byte"
        case .kilobyte:
            "KB"
        case .megabyte:
            "MB"
        case .gigabyte:
            "GB"
        case .terabyte:
            "TB"
        }
    }
    
    public static func from(byte: Double) -> Self {
        let fileSizeKB = Double(byte) / 1024.0
        let fileSizeMB = fileSizeKB / 1024.0
        let fileSizeGB = fileSizeMB / 1024.0
        let fileSizeTB = fileSizeGB / 1024.0
        
        return if fileSizeTB >= 1 {
            .terabyte
        } else if fileSizeGB >= 1 {
            .gigabyte
        } else if fileSizeMB >= 1 {
            .megabyte
        } else if fileSizeKB >= 1 {
            .kilobyte
        } else {
            .byte
        }
    }
}
