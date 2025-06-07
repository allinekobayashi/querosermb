import Foundation

protocol ExchangeInteractorProtocol {
    func fetchExchanges(forceRefresh: Bool) async throws -> ExchangeGroup
}

final class ExchangeInteractor: ExchangeInteractorProtocol {
    private let service: ExchangeServiceProtocol
    private let mapper: ExchangeMapperProtocol
    
    init(service: ExchangeServiceProtocol, mapper: ExchangeMapperProtocol = ExchangeMapper()) {
        self.service = service
        self.mapper = mapper
    }
    
    func fetchExchanges(forceRefresh: Bool) async throws -> ExchangeGroup {
        let exchangeResponse = try await service.fetchExchanges(forceRefresh: forceRefresh)
        return mapper.map(exchangeResponse)
    }
}
