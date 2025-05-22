@testable import MercadoBitcoinExercise
import XCTest

final class ExchangeViewModelMapperTests: XCTestCase {
    func test_map_emptyList_returnsEmptyViewModelList() {
        let mapper = ExchangeViewModelMapper()
        let exchanges: [Exchange] = []
        
        let result = mapper.map(exchanges)
        
        XCTAssertTrue(result.isEmpty)
    }

    func test_map_exchangeWithNoVolumes_returnsEmptyVolumesArray() {
        let mapper = ExchangeViewModelMapper()
        let exchange = Exchange(name: "TestEx", id: "1", website: nil, isActive: true, volumes: [])
        
        let result = mapper.map([exchange])
        
        XCTAssertEqual(result.first?.volumes, [])
    }

    func test_map_exchangeWithDayVolume_returnsFormattedVolumesArray() {
        let mapper = ExchangeViewModelMapper()
        let volume = ExchangeVolume(period: .day, volume: 1234567, currencyCode: "USD")
        let exchange = Exchange(name: "TestEx", id: "1", website: nil, isActive: true, volumes: [volume])
        
        let result = mapper.map([exchange])
        
        XCTAssertEqual(result.first?.volumes, ["1.23M USD (per day)"])
    }

    func test_map_exchangeWithMultipleVolumes_returnsAllFormattedVolumes() {
        let mapper = ExchangeViewModelMapper()
        let hourVolume = ExchangeVolume(period: .hour, volume: 1000, currencyCode: "USD")
        let dayVolume = ExchangeVolume(period: .day, volume: 2000, currencyCode: "USD")
        let exchange = Exchange(name: "TestEx", id: "1", website: nil, isActive: true, volumes: [hourVolume, dayVolume])
        
        let result = mapper.map([exchange])
        
        XCTAssertEqual(result.first?.volumes, ["1K USD (per hour)", "2K USD (per day)"])
    }
}
