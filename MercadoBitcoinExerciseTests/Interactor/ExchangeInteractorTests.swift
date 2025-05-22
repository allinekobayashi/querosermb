@testable import MercadoBitcoinExercise
import XCTest

class ExchangeInteractorTests: XCTestCase {
    func testFetchExchanges_GivenValidServiceAndMapper_WhenFetchExchanges_ThenReturnsMappedExchanges() async throws {
        let mockService = MockExchangeService()
        let response = MockExchangesResponse().build()
        mockService.result = .success(response)
        let mockMapper = MockExchangeMapper()
        mockMapper.result = MockExchanges().build()
        
        let interactor = ExchangeInteractor(service: mockService, mapper: mockMapper)
        
        let exchanges = try await interactor.fetchExchanges(forceRefresh: true)
        
        XCTAssertTrue(mockService.fetchExchangesCalled)
        XCTAssertTrue(mockMapper.mapCalled)
        XCTAssertEqual(mockMapper.lastResponse, response)
        
        XCTAssertEqual(exchanges, mockMapper.result)
    }

    func testFetchExchanges_GivenServiceThrowsError_WhenFetchExchanges_ThenThrowsError() async {
        let mockService = MockExchangeService()
        mockService.result = .failure(URLError(.notConnectedToInternet))
        let mockMapper = MockExchangeMapper()
        let interactor = ExchangeInteractor(service: mockService, mapper: mockMapper)
        
        do {
            _ = try await interactor.fetchExchanges(forceRefresh: true)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }
}
