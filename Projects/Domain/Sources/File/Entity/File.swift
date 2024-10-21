public struct File: Entity {
    public let url: String
    public let name: String
    public let byte: Int?
    
    public init(url: String, name: String, byte: Int) {
        self.url = url
        self.name = name
        self.byte = byte
    }
    
    public init(message: String) {
        let splittedMessage = message.split(separator: "::").map { String($0) }
        self.url = splittedMessage[0]
        self.name = splittedMessage[1]
        self.byte = Int(splittedMessage[2])
    }
    
    public var joinedString: String {
        var s = "\(url)::\(name)"
        if let byte {
            s += "::\(byte)"
        }
        return s
    }
}

extension File {
    public var volume: FileVolume? {
        if let byte {
            return FileVolume.from(byte: Double(byte))
        } else {
            return nil
        }
    }
    
    public var size: Double? {
        guard let byte, let volume else { return nil }
        let fileSizeKB = Double(byte) / 1024.0
        let fileSizeMB = fileSizeKB / 1024.0
        let fileSizeGB = fileSizeMB / 1024.0
        let fileSizeTB = fileSizeGB / 1024.0
        return switch volume {
        case .byte:
            fileSizeTB
        case .kilobyte:
            fileSizeKB
        case .megabyte:
            fileSizeMB
        case .gigabyte:
            fileSizeGB
        case .terabyte:
            fileSizeTB
        }
    }
}
