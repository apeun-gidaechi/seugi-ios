import Domain

public final class FakeKeyValueRepo: KeyValueRepo {
    public init() {}
    public func save(key: StorableKeys, value: Any) {}
    
    public func load(key: StorableKeys) -> Any? { nil }
    
    public func load<T>(key: StorableKeys) -> T? { nil }
    
    public func delete(key: StorableKeys) {}
    
    public func save(key: String, value: Any) {}
    
    public func load(key: String) -> Any? { nil }
    
    public func load<T>(key: String) -> T? { nil }
    
    public func delete(key: String) {}
}
