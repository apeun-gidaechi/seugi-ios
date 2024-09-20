import OSLog

extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let debug = OSLog(subsystem: subsystem, category: "Debug")
    static let info = OSLog(subsystem: subsystem, category: "Info")
    static let error = OSLog(subsystem: subsystem, category: "Error")
}

public struct Log {
    enum Level {
        case debug
        case info
        case network
        case error
        case custom(categoryName: String)
        
        var category: String {
            switch self {
            case .debug: "Debug"
            case .info: "Info"
            case .network: "Network"
            case .error: "Error"
            case .custom(let categoryName): categoryName
            }
        }
        
        var osLog: OSLog {
            switch self {
            case .debug: .debug
            case .info: .info
            case .network: .network
            case .error: .error
            case .custom: .debug
            }
        }
        
        var osLogType: OSLogType {
            switch self {
            case .debug: .debug
            case .info: .info
            case .network: .default
            case .error: .error
            case .custom: .debug
            }
        }
    }
    
    static private func log(_ message: Any, _ arguments: [Any], level: Log.Level) {
        #if LOG
        if #available(iOS 14.0, *) {
            let extraMessage: String = arguments.map { String(describing: $0) }.joined(separator: " ")
            let logger = Logger(subsystem: OSLog.subsystem, category: level.category)
            let logMessage = "\(message) \(extraMessage)"
            switch level {
            case .debug,
                 .custom:
                logger.debug("\(logMessage, privacy: .public)")
            case .info:
                logger.info("\(logMessage, privacy: .public)")
            case .network:
                logger.log("\(logMessage, privacy: .public)")
            case .error:
                logger.error("\(logMessage, privacy: .public)")
            }
        } else {
            let extraMessage: String = arguments.map { String(describing: $0) }.joined(separator: " ")
            os_log("%{public}@", log: level.osLog, type: level.osLogType, "\(message) \(extraMessage)")
        }
        #endif
    }
}

public extension Log {
    static func debug(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .debug)
    }

    static func info(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .info)
    }

    static func network(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .network)
    }

    static func error(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .network)
    }

    static func custom(category: String, _ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .custom(categoryName: category))
    }
}
