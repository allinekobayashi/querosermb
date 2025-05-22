import UIKit
@testable import MercadoBitcoinExercise

final class MockExchangeRouter: ExchangeRouterProtocol {
    var showExchangeDetailCalled = false
    var exchangePassed: ExchangeViewModel?
    var viewControllerPassed: UIViewController?
    
    func showExchangeDetail(exchange: ExchangeViewModel, from viewController: UIViewController) {
        showExchangeDetailCalled = true
        exchangePassed = exchange
        viewControllerPassed = viewController
    }
} 