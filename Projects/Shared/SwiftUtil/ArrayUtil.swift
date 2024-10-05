import Foundation

public enum ArrayUtil {
    public static func splitArray<T>(array: [T]) -> [[T]] {
        let middleIndex = Int(ceil(Double(array.count) / 2.0))
        let firstHalf = Array(array[0..<middleIndex])
        let secondHalf = Array(array[middleIndex..<array.count])
        return [firstHalf, secondHalf]
    }
}

public extension Array {
    func getOrNil(idx: Int) -> Element? {
        let strLength = self.count
        guard strLength > idx else {
            return nil
        }
        return self[idx]
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
