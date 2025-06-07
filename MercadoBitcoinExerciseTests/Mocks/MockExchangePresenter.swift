import UIKit
@testable import MercadoBitcoinExercise

final class MockExchangePresenter: ExchangePresenterProtocol {
    var exchanges: [ExchangeViewModel] = []
    var didCallViewDidLoad = false
    var didCallDidSelectExchange: ExchangeViewModel?
    var didCallConfigureWithView: ExchangesViewProtocol?
    var didCallPullToRefresh = false
    var didCallOnRetry = false
    var didCallViewWillAppear = false
    var didCallViewWillDisappear = false

    func viewDidLoad() {
        didCallViewDidLoad = true
    }
    
    func didSelectExchange(_ exchange: ExchangeViewModel) {
        didCallDidSelectExchange = exchange
    }
    
    func configure(with view: ExchangesViewProtocol) {
        didCallConfigureWithView = view
    }
    
    func pullToRefresh() {
        didCallPullToRefresh = true
    }
    
    func onRetry() {
        didCallOnRetry = true
    }
    
    func viewWillAppear() {
        didCallViewWillAppear = true
    }
    
    func viewWillDisappear() {
        didCallViewWillDisappear = true
    }
}
