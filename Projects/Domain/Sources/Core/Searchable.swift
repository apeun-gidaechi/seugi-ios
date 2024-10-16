public protocol Searchable {
    var searchString: String { get }
}

public extension Array where Element: Searchable {
    func search(text: String) -> Self {
        if text.isEmpty {
            self
        } else {
            self.filter { $0.searchString.contains(text) }
        }
    }
}
