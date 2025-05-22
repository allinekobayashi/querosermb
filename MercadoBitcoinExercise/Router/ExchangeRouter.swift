import UIKit

protocol ExchangeRouterProtocol: AnyObject {
    func showExchangeDetail(exchange: ExchangeViewModel, from viewController: UIViewController)
}

final class ExchangeRouter: ExchangeRouterProtocol {
    func showExchangeDetail(exchange: ExchangeViewModel, from viewController: UIViewController) {
        let detailVC = ExchangeDetailViewController(exchange: exchange)
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
} 