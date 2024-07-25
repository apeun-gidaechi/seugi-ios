public protocol Entity: Hashable {}
extension String: Entity {}
extension Int: Entity {}
extension Double: Entity {}
extension Array: Entity where Element: Hashable {}
