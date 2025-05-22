@testable import MercadoBitcoinExercise
import Foundation

final class MockExchangeMapper: ExchangeMapperProtocol {
    var result: [Exchange] = []
    private(set) var mapCalled = false
    private(set) var lastResponse: [ExchangeResponse]?
    
    func map(_ response: [ExchangeResponse]) -> [Exchange] {
        mapCalled = true
        lastResponse = response
        return result
    }
}
