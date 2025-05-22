import Foundation

protocol ExchangeServiceProtocol {
    func fetchExchanges(forceRefresh: Bool) async throws -> [ExchangeResponse]
}

final class ExchangeService: ExchangeServiceProtocol {
    private let baseURL = "https://rest.coinapi.io/v1"
    private let session: URLSessionProtocol
    private let configurationManager: ConfigurationManagerProtocol
    
    init(session: URLSessionProtocol = URLSession.shared,
         configurationManager: ConfigurationManagerProtocol = ConfigurationManager.shared
    ) {
        self.session = session
        self.configurationManager = configurationManager
    }
    
    func fetchExchanges(forceRefresh: Bool) async throws -> [ExchangeResponse] {
        guard let url = URL(string: "\(baseURL)/exchanges") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(configurationManager.coinApiKey(), forHTTPHeaderField: "X-CoinAPI-Key")
        request.timeoutInterval = 30
        request.cachePolicy = forceRefresh ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad
        request.setValue("max-age=600", forHTTPHeaderField: "Cache-Control")
        
        let (data, response) = try await session.data(for: request)
        debug(data, response)
        
        return try JSONDecoder().decode([ExchangeResponse].self, from: data)
    }
    
    private func debug(_ data: Data, _ response: URLResponse) {
        if let string = String(data: data, encoding: .utf8) {
            print("Response body:\n\(string)")
        } else {
            print("Received non-text data")
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status code: \(httpResponse.statusCode)")
            print("Headers: \(httpResponse.allHeaderFields)")
        }
    }
    
}
