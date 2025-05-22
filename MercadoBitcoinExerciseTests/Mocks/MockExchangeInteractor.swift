import Foundation
@testable import MercadoBitcoinExercise

final class MockExchangeInteractor: ExchangeInteractorProtocol {
    private(set) var fetchExchangesCalled = false
    private(set) var forceRefresh: Bool?
    var mockExchanges: [Exchange] = []
    var mockError: Error?
    
    func fetchExchanges(forceRefresh: Bool) async throws -> [Exchange] {
        self.fetchExchangesCalled = true
        self.forceRefresh = forceRefresh
        
        if let error = mockError {
            throw error
        }
        
        return mockExchanges
    }
}
