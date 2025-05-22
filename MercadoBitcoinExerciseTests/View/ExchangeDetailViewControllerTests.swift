import XCTest
import SnapshotTesting
import UIKit
@testable import MercadoBitcoinExercise

final class ExchangeDetailViewControllerTests: XCTestCase {
    func testExchangeDetailView_snapshot() {
        let vm = ExchangeViewModel(
            id: "test-id",
            name: "Test Exchange",
            website: "https://test.com",
            status: "Active",
            volumes: ["100 USD per day"]
        )
        let viewController = ExchangeDetailViewController(exchange: vm)
        
        viewController.loadViewIfNeeded()
        viewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
        
        assertSnapshot(of: viewController, as: .image)
    }
}
