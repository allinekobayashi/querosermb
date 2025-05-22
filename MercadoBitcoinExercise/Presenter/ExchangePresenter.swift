import Foundation
import UIKit

protocol ExchangePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectExchange(_ exchange: ExchangeViewModel)
    func configure(with view: ExchangesViewProtocol)
    func pullToRefresh()
    func onRetry()
}

final class ExchangePresenter: ExchangePresenterProtocol {
    private let interactor: ExchangeInteractorProtocol
    private let mapper: ExchangeViewModelMapperProtocol
    private let router: ExchangeRouterProtocol
    weak var view: ExchangesViewProtocol?
    
    init(
        interactor: ExchangeInteractorProtocol,
        mapper: ExchangeViewModelMapperProtocol = ExchangeViewModelMapper(),
        router: ExchangeRouterProtocol = ExchangeRouter()
    ) {
        self.interactor = interactor
        self.mapper = mapper
        self.router = router
    }
    
    func viewDidLoad() {
        // If needed, add tracking here
        view?.showLoading()
        fetchExchanges()
    }
    
    func didSelectExchange(_ exchange: ExchangeViewModel) {
        // If needed, add tracking here
        if let viewController = view as? UIViewController {
            router.showExchangeDetail(exchange: exchange, from: viewController)
        }
    }
    
    func pullToRefresh() {
        // If needed, add tracking here
        fetchExchanges(forceRefresh: true)
    }
    
    func onRetry() {
        // If needed, add tracking here
        view?.showLoading()
        fetchExchanges()
    }
    
    func configure(with view: any ExchangesViewProtocol) {
        self.view = view
    }
    
    private func fetchExchanges(forceRefresh: Bool = false) {
        Task {
            do {
                let exchanges = try await interactor.fetchExchanges(forceRefresh: forceRefresh)
                await MainActor.run {
                    view?.showExchanges(mapper.map(exchanges))
                }
            } catch {
                await MainActor.run {
                    view?.showError(error.localizedDescription)
                }
            }
        }
    }
}
