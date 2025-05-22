import Foundation

protocol ExchangeMapperProtocol {
    func map(_ response: [ExchangeResponse]) -> [Exchange]
}

final class ExchangeMapper: ExchangeMapperProtocol {
    func map(_ response: [ExchangeResponse]) -> [Exchange] {
        return response.compactMap(mapEachExchange)
            
    }
    
    private func mapEachExchange(_ exchangeResponse: ExchangeResponse) -> Exchange {
        Exchange(
            name: exchangeResponse.name,
            id: exchangeResponse.id,
            website: exchangeResponse.website,
            isActive: exchangeResponse.dataEnd == nil,
            volumes: mapVolumes(exchangeResponse)
        )
    }
    
    private func mapVolumes(_ exchangeResponse: ExchangeResponse) -> [ExchangeVolume] {
        var volumes: [ExchangeVolume] = []
        if let v = exchangeResponse.volume1hrsUsd {
            volumes.append(ExchangeVolume(period: .hour, volume: v, currencyCode: "USD"))
        }
        if let v = exchangeResponse.volume1dayUsd {
            volumes.append(ExchangeVolume(period: .day, volume: v, currencyCode: "USD"))
        }
        if let v = exchangeResponse.volume1mthUsd {
            volumes.append(ExchangeVolume(period: .month, volume: v, currencyCode: "USD"))
        }
        return volumes
    }
}
