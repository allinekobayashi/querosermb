import Foundation
@testable import MercadoBitcoinExercise

final class MockExchangeInteractor: ExchangeInteractorProtocol {
    private(set) var fetchExchangesCalled = false
    private(set) var forceRefresh: Bool?
    var mockExchanges: ExchangeGroup = ExchangeGroup(
        lastUpdated: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 7))!,
        exchanges: []
    )
    var mockError: Error?
    
    func fetchExchanges(forceRefresh: Bool) async throws -> ExchangeGroup {
        self.fetchExchangesCalled = true
        self.forceRefresh = forceRefresh
        
        if let error = mockError {
            throw error
        }
        
        return mockExchanges
    }
}
