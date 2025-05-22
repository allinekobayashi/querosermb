@testable import MercadoBitcoinExercise
import XCTest

final class ExchangePresenterTests: XCTestCase {
    private var presenter: ExchangePresenter!
    private var mockRouter: MockExchangeRouter!
    private var mockView: MockExchangesView!
    private var mockInteractor: MockExchangeInteractor!
    private var mockMapper: MockExchangeViewModelMapper!
    
    private let expectedExchanges = [
        ExchangeViewModel(
            id: "test-id",
            name: "Test Exchange",
            website: "https://test.com",
            status: "Active",
            volumes: ["100 USD per day"]
        )
    ]
    
    override func setUp() {
        super.setUp()
        mockRouter = MockExchangeRouter()
        mockView = MockExchangesView()
        mockInteractor = MockExchangeInteractor()
        mockMapper = MockExchangeViewModelMapper()
        
        presenter = ExchangePresenter(
            interactor: mockInteractor,
            mapper: mockMapper,
            router: mockRouter
        )
        
        presenter.configure(with: mockView)
    }
    
    override func tearDown() {
        presenter = nil
        mockRouter = nil
        mockView = nil
        mockInteractor = nil
        mockMapper = nil
        super.tearDown()
    }
    
    func testDidSelectExchangeGivenPresenterWhenDidSelectExchangeThenRouterCalledWithCorrectParameters() {
        let exchange = ExchangeViewModel(
            id: "test-id",
            name: "Test Exchange",
            website: "https://test.com",
            status: "Active",
            volumes: ["100 USD per day"]
        )
        
        presenter.didSelectExchange(exchange)
        
        XCTAssertTrue(mockRouter.showExchangeDetailCalled)
        XCTAssertEqual(mockRouter.exchangePassed?.id, exchange.id)
        XCTAssertEqual(mockRouter.viewControllerPassed, mockView)
    }
    
    func testViewDidLoadGivenPresenterWhenViewDidLoadThenShowLoadingAndFetchExchanges() async {
        mockMapper.mockMappedExchanges = expectedExchanges
        
        presenter.viewDidLoad()
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        await MainActor.run {
            XCTAssertTrue(mockView.showLoadingCalled)
            XCTAssertTrue(mockInteractor.fetchExchangesCalled)
            XCTAssertEqual(mockInteractor.forceRefresh, false)
            XCTAssertEqual(mockView.exchangesPassed, expectedExchanges)
            XCTAssertTrue(mockView.showExchangesCalled)
        }
    }
    
    func testPullToRefreshGivenPresenterWhenPullToRefreshThenFetchExchangesWithForceRefresh() async {
        mockMapper.mockMappedExchanges = expectedExchanges
        
        presenter.pullToRefresh()
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        await MainActor.run {
            XCTAssertFalse(mockView.showLoadingCalled)
            XCTAssertTrue(mockInteractor.fetchExchangesCalled)
            XCTAssertEqual(mockInteractor.forceRefresh, true)
            XCTAssertEqual(mockView.exchangesPassed, expectedExchanges)
            XCTAssertTrue(mockView.showExchangesCalled)
        }
    }
    
    func testOnRetryGivenPresenterWhenOnRetryThenShowLoadingAndFetchExchanges() async {
        mockMapper.mockMappedExchanges = expectedExchanges
        
        presenter.onRetry()
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        await MainActor.run {
            XCTAssertTrue(mockView.showLoadingCalled)
            XCTAssertTrue(mockInteractor.fetchExchangesCalled)
            XCTAssertEqual(mockInteractor.forceRefresh, false)
            XCTAssertEqual(mockView.exchangesPassed, expectedExchanges)
            XCTAssertTrue(mockView.showExchangesCalled)
        }
    }
}
