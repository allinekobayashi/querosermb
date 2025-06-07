import Foundation
@testable import MercadoBitcoinExercise

final class MockTimer: TimerProtocol {
    var scheduleCallCount = 0
    var invalidateCallCount = 0
    var lastTimeInterval: TimeInterval?
    var lastRepeats: Bool?
    var lastBlock: (() -> Void)?
    var isRunning = false
    
    func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping () -> Void) {
        scheduleCallCount += 1
        lastTimeInterval = interval
        lastRepeats = repeats
        lastBlock = block
        isRunning = true
    }
    
    func invalidate() {
        invalidateCallCount += 1
        isRunning = false
        lastBlock = nil
    }
    
    func fire() {
        lastBlock?()
    }
}
