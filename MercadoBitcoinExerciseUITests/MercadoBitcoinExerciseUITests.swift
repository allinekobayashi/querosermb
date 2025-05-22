import XCTest

final class MercadoBitcoinExerciseUITests: XCTestCase {
    func testExchangeListAndDetailFlow() {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for the exchange list table to appear
        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 5), "Exchange list table should appear")
        
        // Tap the first cell if it exists
        let firstCell = table.cells.firstMatch
        if firstCell.exists {
            firstCell.tap()
            // Wait for the detail view (assume navigation bar title or a label exists)
            let detailNavBar = app.navigationBars.element(boundBy: 0)
            XCTAssertTrue(detailNavBar.waitForExistence(timeout: 3), "Detail view should appear after tapping exchange cell")
        } else {
            XCTFail("No exchange cells found in the list")
        }
    }
}
