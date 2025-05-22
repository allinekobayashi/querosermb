@testable import MercadoBitcoinExercise
import Foundation

enum MockURLSessionError: Error {
    case noMockResponse
}

final class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    var lastRequest: URLRequest?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        lastRequest = request
        if let error = mockError {
            throw error
        }
        guard let data = mockData, let response = mockResponse else {
            throw MockURLSessionError.noMockResponse
        }
        return (data, response)
    }
}
