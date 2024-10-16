public protocol Entity: Decodable, Hashable {}

extension String: Entity {}
extension Int: Entity {}
extension Float: Entity {}
extension Double: Entity {}
extension Array: Entity where Element: Entity {}
