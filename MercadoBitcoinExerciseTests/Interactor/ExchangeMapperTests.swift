@testable import MercadoBitcoinExercise
import XCTest

final class ExchangeMapperTests: XCTestCase {

    func testMap_GivenAllVolumesPresentAndActive_WhenMap_ThenAllFieldsAndVolumesAreMapped() {
        let mapper = ExchangeMapper()
        let response = [ExchangeResponse(
            name: "Binance",
            id: "BINANCE",
            website: "https://www.binance.com/",
            dataStart: "2017-07-14",
            dataEnd: nil,
            volume1hrsUsd: 256938679.43,
            volume1dayUsd: 5734568954.76,
            volume1mthUsd: 167892044603.54
        )]
        
        let result = mapper.map(response)
        
        guard let exchange = result.exchanges.first else {
            XCTFail("Mapping failed")
            return
        }
        
        XCTAssertEqual(exchange.name, "Binance")
        XCTAssertEqual(exchange.id, "BINANCE")
        XCTAssertEqual(exchange.website, "https://www.binance.com/")
        XCTAssertTrue(exchange.isActive)
        XCTAssertEqual(exchange.volumes.count, 3)
        XCTAssertTrue(exchange.volumes.contains { $0.period == .hour && $0.volume == 256938679.43 })
        XCTAssertTrue(exchange.volumes.contains { $0.period == .day && $0.volume == 5734568954.76 })
        XCTAssertTrue(exchange.volumes.contains { $0.period == .month && $0.volume == 167892044603.54 })
    }

    func testMap_GivenOnlyHourVolumeAndInactive_WhenMap_ThenOnlyHourVolumeAndInactiveMapped() {
        let mapper = ExchangeMapper()
        let response = [ExchangeResponse(
            name: "Coinbase Pro",
            id: "COINBASE",
            website: "https://pro.coinbase.com/",
            dataStart: "2015-01-08",
            dataEnd: "2024-01-01",
            volume1hrsUsd: 162753954.21,
            volume1dayUsd: nil,
            volume1mthUsd: nil
        )]
        
        let result = mapper.map(response)
        
        guard let exchange = result.exchanges.first else {
            XCTFail("Mapping failed")
            return
        }
        
        XCTAssertEqual(exchange.name, "Coinbase Pro")
        XCTAssertEqual(exchange.id, "COINBASE")
        XCTAssertEqual(exchange.website, "https://pro.coinbase.com/")
        XCTAssertFalse(exchange.isActive)
        XCTAssertEqual(exchange.volumes.count, 1)
        XCTAssertEqual(exchange.volumes.first?.period, .hour)
        XCTAssertEqual(exchange.volumes.first?.volume, 162753954.21)
    }

    func testMap_GivenNoVolumesPresent_WhenMap_ThenNoVolumesAndActiveMapped() {
        let mapper = ExchangeMapper()
        let response = [ExchangeResponse(
            name: "Kraken",
            id: "KRAKEN",
            website: nil,
            dataStart: nil,
            dataEnd: nil,
            volume1hrsUsd: nil,
            volume1dayUsd: nil,
            volume1mthUsd: nil
        )]
        
        let result = mapper.map(response)
        
        guard let exchange = result.exchanges.first else {
            XCTFail("Mapping failed")
            return
        }
        
        XCTAssertEqual(exchange.name, "Kraken")
        XCTAssertEqual(exchange.id, "KRAKEN")
        XCTAssertNil(exchange.website)
        XCTAssertTrue(exchange.isActive)
        XCTAssertTrue(exchange.volumes.isEmpty)
    }

}
