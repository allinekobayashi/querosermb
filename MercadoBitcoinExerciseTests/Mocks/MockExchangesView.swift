import UIKit
@testable import MercadoBitcoinExercise

final class MockExchangesView: UIViewController, ExchangesViewProtocol {
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var showExchangesCalled = false
    var showErrorCalled = false
    
    var exchangesPassed: [ExchangeViewModel]?
    var errorMessagePassed: String?
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
    func showExchanges(_ exchanges: [ExchangeViewModel]) {
        showExchangesCalled = true
        exchangesPassed = exchanges
    }
    
    func showError(_ message: String) {
        showErrorCalled = true
        errorMessagePassed = message
    }
}
