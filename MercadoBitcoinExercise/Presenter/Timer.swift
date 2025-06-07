import Foundation

protocol TimerProtocol {
    func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping () -> Void)
    func invalidate()
}

final class RealTimer: TimerProtocol {
    private var timer: Timer?
    
    func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping () -> Void) {
        invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats) { _ in
            block()
        }
    }
    
    func invalidate() {
        timer?.invalidate()
        timer = nil
    }
}
