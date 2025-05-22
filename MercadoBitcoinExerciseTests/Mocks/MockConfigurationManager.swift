import Foundation
@testable import MercadoBitcoinExercise

final class MockConfigurationManager: ConfigurationManagerProtocol {
    var coinApiKeyValue: String = "MOCK_API_KEY"
    private(set) var coinApiKeyCalled = false
    
    func coinApiKey() -> String {
        coinApiKeyCalled = true
        return coinApiKeyValue
    }
}
