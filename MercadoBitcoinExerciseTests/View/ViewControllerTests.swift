import XCTest
import SnapshotTesting
import UIKit
@testable import MercadoBitcoinExercise

final class ViewControllerTests: XCTestCase {
    func testView_snapshot() {
        let viewModel = [
            ExchangeViewModel(
                id: "1",
                name: "Binance",
                website: "https://binance.com",
                status: "Active",
                volumes: ["792.77M USD (per hour)", "15.36B USD (per day)", "537.78B USD (per month)"]
            ),
            ExchangeViewModel(
                id: "2",
                name: "Coinbase",
                website: nil,
                status: "Active",
                volumes: ["15.36B USD (per day)"]
            ),
            ExchangeViewModel(
                id: "3",
                name: "Kraken",
                website: "https://kraken.com",
                status: "Inactive",
                volumes: []
            ),
            ExchangeViewModel(
                id: "4",
                name: "Bitstamp",
                website: "https://bitstamp.net",
                status: "Active", 
                volumes: ["792.77M USD (per hour)", "15.36B USD (per day)"]
            )
        ]
        
        let mockPresenter = MockExchangePresenter()
        let viewController = ViewController(presenter: mockPresenter)
        viewController.showExchanges(viewModel)
        
        viewController.loadViewIfNeeded()
        viewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
        
        assertSnapshot(of: viewController, as: .image)
    }
}
