import Foundation
import Combine

private let timeLimit = 300
public final class TimerManager: ObservableObject {
    
    @Published public var timeRemaining = timeLimit
    public let date = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var subscriptions = Set<AnyCancellable>()
    private var completion: (() -> Void)?
    
    public init() {
        observeTimer()
    }
    
    public func startTimer(completion: @escaping () -> Void) {
        self.completion = completion
        let calendar = Calendar.current
        let targetTime = calendar.date(byAdding: .second, value: timeLimit, to: date, wrappingComponents: false) ?? .now
        let remainSeconds = Int(targetTime.timeIntervalSince(date))
        timeRemaining = remainSeconds
    }
    
    func observeTimer() {
        timer.sink { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                if let completion = self.completion {
                    completion()
                }
            }
        }
        .store(in: &subscriptions)
    }
}
