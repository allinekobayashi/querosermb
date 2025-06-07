@testable import MercadoBitcoinExercise
import XCTest

final class ExchangeViewModelMapperTests: XCTestCase {
    let testDate: Date = Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 7)) ?? Date()
    
    func test_map_emptyList_returnsEmptyViewModelList() {
        let mapper = ExchangeViewModelMapper()
        let exchangeGroup = ExchangeGroup(lastUpdated: testDate, exchanges: [])
        
        let result = mapper.map(exchangeGroup)
        
        XCTAssertTrue(result.exchanges.isEmpty)
    }
    
    func test_map_date() {
        let mapper = ExchangeViewModelMapper()
        let exchange = Exchange(name: "TestEx", id: "1", website: nil, isActive: true, volumes: [])
        let exchangeGroup = ExchangeGroup(lastUpdated: testDate, exchanges: [exchange])
        
        let result = mapper.map(exchangeGroup)
        
        XCTAssertEqual(result.lastUpdated, "Last updated: 07/01/2025, 00:00")
    }

    func test_map_exchangeWithNoVolumes_returnsEmptyVolumesArray() {
        let mapper = ExchangeViewModelMapper()
        let exchange = Exchange(name: "TestEx", id: "1", website: nil, isActive: true, volumes: [])
        let exchangeGroup = ExchangeGroup(lastUpdated: testDate, exchanges: [exchange])
        
        let result = mapper.map(exchangeGroup)
        
        XCTAssertEqual(result.exchanges.first?.volumes, [])
    }

    func test_map_exchangeWithDayVolume_returnsFormattedVolumesArray() {
        let mapper = ExchangeViewModelMapper()
        let volume = ExchangeVolume(period: .day, volume: 1234567, currencyCode: "USD")
        let exchange = Exchange(name: "TestEx", id: "1", website: nil, isActive: true, volumes: [volume])
        let exchangeGroup = ExchangeGroup(lastUpdated: testDate, exchanges: [exchange])
        
        let result = mapper.map(exchangeGroup)
        
        XCTAssertEqual(result.exchanges.first?.volumes, ["1.23M USD (per day)"])
    }

    func test_map_exchangeWithMultipleVolumes_returnsAllFormattedVolumes() {
        let mapper = ExchangeViewModelMapper()
        let hourVolume = ExchangeVolume(period: .hour, volume: 1000, currencyCode: "USD")
        let dayVolume = ExchangeVolume(period: .day, volume: 2000, currencyCode: "USD")
        let exchange = Exchange(name: "TestEx", id: "1", website: nil, isActive: true, volumes: [hourVolume, dayVolume])
        let exchangeGroup = ExchangeGroup(lastUpdated: testDate, exchanges: [exchange])
        
        let result = mapper.map(exchangeGroup)
        
        XCTAssertEqual(result.exchanges.first?.volumes, ["1K USD (per hour)", "2K USD (per day)"])
    }
}
