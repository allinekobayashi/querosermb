import Foundation
@testable import MercadoBitcoinExercise

final class MockExchangeViewModelMapper: ExchangeViewModelMapperProtocol {
    var mockMappedExchanges: ExchangeListViewModel?
    
    func map(_ exchanges: ExchangeGroup) -> ExchangeListViewModel {
        guard let mockData = mockMappedExchanges else {
            return .init(lastUpdated: "lastUpdated", exchanges: [])
        }
        return mockData
    }
}
