import UIKit
@testable import MercadoBitcoinExercise

final class MockExchangesView: UIViewController, ExchangesViewProtocol {
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var showExchangesCalled = false
    var showErrorCalled = false
    
    var viewModelPassed: ExchangeListViewModel?
    var errorMessagePassed: String?
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
    func showExchanges(_ viewModel: ExchangeListViewModel) {
        showExchangesCalled = true
        viewModelPassed = viewModel
    }
    
    func showError(_ message: String) {
        showErrorCalled = true
        errorMessagePassed = message
    }
}
