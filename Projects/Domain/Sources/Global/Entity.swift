public protocol Entity: Equatable {}
extension String: Entity {}
extension Int: Entity {}
extension Double: Entity {}
extension Array: Entity where Element: Equatable {}
