import Foundation

public extension Array {
    func getOrNil(idx: Int) -> Element? {
        let strLength = self.count
        guard strLength > idx else {
            return nil
        }
        return self[idx]
    }
    
    // If position parameter is nil then position is middle index
    func splitArray(position: Int? = nil) -> ([Element], [Element]) {
        let position = position ?? Int(ceil(Double(self.count) / 2.0))
        let calcedPosision = if self.count <= position {
            self.count
        } else {
            position
        }
        let firstHalf = Array(self[0..<calcedPosision])
        let secondHalf = Array(self[calcedPosision..<self.count])
        return (firstHalf, secondHalf)
    }
    
    static func from(_ tuple: (Element, Element)) -> Array<Element> {
        return [tuple.0, tuple.1]
    }
}

public extension Array where Element: Equatable {
    // 항목이 있으면 제거하고, 없으면 추가
    mutating func toggle(element: Element) {
        if let index = self.firstIndex(of: element) { // 배열에 항목이 있으면 제거
            self.remove(at: index)
        } else { // 배열에 항목이 없으면 추가
            self.append(element)
        }
    }

    // 조건에 맞는 항목을 교체하거나 없으면 추가
    mutating func replace(
        element: Element,
        where predicate: (Element) -> Bool
    ) {
        if let index = self.firstIndex(where: predicate) { // 조건에 맞는 항목이 있으면 교체
            self[index] = element
        } else { // 조건에 맞는 항목이 없으면 추가
            self.append(element)
        }
    }
}
