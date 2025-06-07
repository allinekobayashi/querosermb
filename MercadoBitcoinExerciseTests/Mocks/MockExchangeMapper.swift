@testable import MercadoBitcoinExercise
import Foundation

final class MockExchangeMapper: ExchangeMapperProtocol {
    var result: ExchangeGroup?
    private(set) var mapCalled = false
    private(set) var lastResponse: [ExchangeResponse]?
    
    func map(_ response: [ExchangeResponse]) -> ExchangeGroup {
        mapCalled = true
        lastResponse = response
        return result ?? ExchangeGroup(
            lastUpdated: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 7)) ?? Date(),
            exchanges: []
        )
    }
}
