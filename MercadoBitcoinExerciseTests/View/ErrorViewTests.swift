import XCTest
import SnapshotTesting
import UIKit
@testable import MercadoBitcoinExercise

final class ErrorViewTests: XCTestCase {
    func testErrorView_snapshot() {
        let errorView = ErrorView()
        errorView.frame = CGRect(x: 0, y: 0, width: 375, height: 812)

        assertSnapshot(of: errorView, as: .image)
    }
}
