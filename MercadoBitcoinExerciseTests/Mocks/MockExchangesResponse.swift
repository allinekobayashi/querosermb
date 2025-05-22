@testable import MercadoBitcoinExercise

struct MockExchangesResponse {
    func build() -> [ExchangeResponse] {
        return [
            ExchangeResponse(
                name: "Binance",
                id: "BINANCE",
                website: "https://www.binance.com/",
                dataStart: nil,
                dataEnd: nil,
                volume1hrsUsd: 11343585.98,
                volume1dayUsd: 20807950466.26,
                volume1mthUsd: 518052111531.11
            ),
            ExchangeResponse(
                name: "Coinbase Pro",
                id: "COINBASE",
                website: "https://pro.coinbase.com/",
                dataStart: "2015-01-08",
                dataEnd: "2024-01-01",
                volume1hrsUsd: 162753954.21,
                volume1dayUsd: nil,
                volume1mthUsd: nil
            ),
            ExchangeResponse(
                name: "Kraken",
                id: "KRAKEN",
                website: nil,
                dataStart: nil,
                dataEnd: nil,
                volume1hrsUsd: nil,
                volume1dayUsd: nil,
                volume1mthUsd: nil
            )
        ]
    }
}
