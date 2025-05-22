import Foundation
@testable import MercadoBitcoinExercise

final class MockExchangeViewModelMapper: ExchangeViewModelMapperProtocol {
    var mockMappedExchanges: [ExchangeViewModel] = []
    
    func map(_ exchanges: [Exchange]) -> [ExchangeViewModel] {
        return mockMappedExchanges
    }
}
