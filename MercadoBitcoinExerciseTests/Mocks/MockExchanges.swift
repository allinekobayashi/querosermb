@testable import MercadoBitcoinExercise

struct MockExchanges {
    func build() -> [Exchange] {
        return [
            // Case 1: All volumes present, active
            Exchange(
                name: "Binance",
                id: "BINANCE",
                website: "https://www.binance.com/",
                isActive: true,
                volumes: [
                    ExchangeVolume(period: .hour, volume: 256938679.43, currencyCode: "USD"),
                    ExchangeVolume(period: .day, volume: 5734568954.76, currencyCode: "USD"),
                    ExchangeVolume(period: .month, volume: 167892044603.54, currencyCode: "USD")
                ]
            ),
            // Case 2: Only 1hr volume present, inactive
            Exchange(
                name: "Coinbase Pro",
                id: "COINBASE",
                website: "https://pro.coinbase.com/",
                isActive: false,
                volumes: [
                    ExchangeVolume(period: .hour, volume: 162753954.21, currencyCode: "USD")
                ]
            ),
            // Case 3: No volumes present
            Exchange(
                name: "Kraken",
                id: "KRAKEN",
                website: nil,
                isActive: true,
                volumes: []
            )
        ]
    }
}
