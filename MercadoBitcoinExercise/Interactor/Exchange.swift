import Foundation

enum ExchangeVolumePeriod {
    case hour
    case day
    case month
}

struct ExchangeVolume: Equatable {
    let period: ExchangeVolumePeriod
    let volume: Double
    let currencyCode: String
}

struct Exchange: Identifiable, Equatable {
    let name: String?
    let id: String
    let website: String?
    let isActive: Bool
    let volumes: [ExchangeVolume]
}
    
