@testable import MercadoBitcoinExercise
import XCTest

class ExchangeServiceTests: XCTestCase {
    
    func testFetchExchanges_GivenMockJSON_WhenFetchExchangesSuccessfully_ThenReturnsDecodedObjects() async throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "MockExchanges", withExtension: "json") else {
            XCTFail("Mock file not found")
            return
        }
        let data = try Data(contentsOf: url)

        let mockURL = URL(string: "https://rest.coinapi.io/v1/exchanges")!
        let mockResponse = HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mockConfigurationManager = MockConfigurationManager()

        let session = MockURLSession()
        session.mockData = data
        session.mockResponse = mockResponse
        
        let expectedResponse = MockExchangesResponse().build()
        
        let service = ExchangeService(session: session, configurationManager: mockConfigurationManager)
        let exchanges = try await service.fetchExchanges(forceRefresh: true)

        XCTAssertEqual(exchanges, expectedResponse)
        XCTAssertEqual(session.lastRequest?.url, mockURL)
        XCTAssertEqual(session.lastRequest?.allHTTPHeaderFields?["X-CoinAPI-Key"], "MOCK_API_KEY")
        XCTAssertTrue(mockConfigurationManager.coinApiKeyCalled)
    }
    
    func testFetchExchanges_GivenMockSessionWithError_WhenFetchExchanges_ThenThrowsError() async throws {
        let session = MockURLSession()
        session.mockError = URLError(.notConnectedToInternet)
        let service = ExchangeService(session: session)
        do {
            _ = try await service.fetchExchanges(forceRefresh: true)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }
}
