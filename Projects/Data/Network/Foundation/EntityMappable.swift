import Domain

protocol EntityMappable {
    associatedtype Entity: Domain.Entity
    func toEntity() -> Entity
}

extension String: EntityMappable {
    func toEntity() -> String {
        self
    }
}

extension Int: EntityMappable {
    func toEntity() -> Int {
        self
    }
}

extension Double: EntityMappable {
    func toEntity() -> Double {
        self
    }
}

extension Array: EntityMappable where Element: EntityMappable {
    typealias Entity = [Element.Entity]
    func toEntity() -> [Element.Entity] {
        map { $0.toEntity() }
    }
}
