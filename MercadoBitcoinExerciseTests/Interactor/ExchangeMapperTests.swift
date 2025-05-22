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
        
        guard let result = mapper.map(response).first else {
            XCTFail("Mapping failed")
            return
        }
        
        XCTAssertEqual(result.name, "Binance")
        XCTAssertEqual(result.id, "BINANCE")
        XCTAssertEqual(result.website, "https://www.binance.com/")
        XCTAssertTrue(result.isActive)
        XCTAssertEqual(result.volumes.count, 3)
        XCTAssertTrue(result.volumes.contains { $0.period == .hour && $0.volume == 256938679.43 })
        XCTAssertTrue(result.volumes.contains { $0.period == .day && $0.volume == 5734568954.76 })
        XCTAssertTrue(result.volumes.contains { $0.period == .month && $0.volume == 167892044603.54 })
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
        
        guard let result = mapper.map(response).first else {
            XCTFail("Mapping failed")
            return
        }
        
        XCTAssertEqual(result.name, "Coinbase Pro")
        XCTAssertEqual(result.id, "COINBASE")
        XCTAssertEqual(result.website, "https://pro.coinbase.com/")
        XCTAssertFalse(result.isActive)
        XCTAssertEqual(result.volumes.count, 1)
        XCTAssertEqual(result.volumes.first?.period, .hour)
        XCTAssertEqual(result.volumes.first?.volume, 162753954.21)
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
        
        guard let result = mapper.map(response).first else {
            XCTFail("Mapping failed")
            return
        }
        
        XCTAssertEqual(result.name, "Kraken")
        XCTAssertEqual(result.id, "KRAKEN")
        XCTAssertNil(result.website)
        XCTAssertTrue(result.isActive)
        XCTAssertTrue(result.volumes.isEmpty)
    }

}
