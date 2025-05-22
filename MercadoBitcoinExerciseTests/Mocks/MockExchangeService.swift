import Foundation
@testable import MercadoBitcoinExercise

final class MockExchangeService: ExchangeServiceProtocol {
    var result: Result<[ExchangeResponse], Error> = .success([])
    private(set) var fetchExchangesCalled = false
    
    func fetchExchanges(forceRefresh: Bool) async throws -> [ExchangeResponse] {
        fetchExchangesCalled = true
        switch result {
        case .success(let responses):
            return responses
        case .failure(let error):
            throw error
        }
    }
}
