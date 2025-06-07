@testable import MercadoBitcoinExercise
import XCTest

final class ExchangePresenterTests: XCTestCase {
    private var presenter: ExchangePresenter!
    private var mockRouter: MockExchangeRouter!
    private var mockView: MockExchangesView!
    private var mockInteractor: MockExchangeInteractor!
    private var mockMapper: MockExchangeViewModelMapper!
    private var mockTimer: MockTimer!
    
    private let expectedExchanges = ExchangeListViewModel(
        lastUpdated: "07/06/2025, 10:37",
        exchanges: [
            ExchangeViewModel(
                id: "test-id",
                name: "Test Exchange",
                website: "https://test.com",
                status: "Active",
                volumes: ["100 USD per day"]
            )
        ]
    )
    
    private let mockExchanges = ExchangeGroup(
        lastUpdated: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 7)) ?? Date(),
        exchanges: MockExchanges().build()
    )
    
    override func setUp() {
        super.setUp()
        mockRouter = MockExchangeRouter()
        mockView = MockExchangesView()
        mockInteractor = MockExchangeInteractor()
        mockMapper = MockExchangeViewModelMapper()
        mockTimer = MockTimer()
        
        presenter = ExchangePresenter(
            interactor: mockInteractor,
            mapper: mockMapper,
            router: mockRouter,
            timer: mockTimer
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
        mockInteractor.mockExchanges = mockExchanges
        
        presenter.viewDidLoad()
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        await MainActor.run {
            XCTAssertTrue(mockView.showLoadingCalled)
            XCTAssertTrue(mockInteractor.fetchExchangesCalled)
            XCTAssertEqual(mockInteractor.forceRefresh, false)
            XCTAssertEqual(mockView.viewModelPassed, expectedExchanges)
            XCTAssertTrue(mockView.showExchangesCalled)
        }
    }
    
    func testPullToRefreshGivenPresenterWhenPullToRefreshThenFetchExchangesWithForceRefresh() async {
        mockMapper.mockMappedExchanges = expectedExchanges
        mockInteractor.mockExchanges = mockExchanges
        
        presenter.pullToRefresh()
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        await MainActor.run {
            XCTAssertFalse(mockView.showLoadingCalled)
            XCTAssertTrue(mockInteractor.fetchExchangesCalled)
            XCTAssertEqual(mockInteractor.forceRefresh, true)
            XCTAssertEqual(mockView.viewModelPassed, expectedExchanges)
            XCTAssertTrue(mockView.showExchangesCalled)
        }
    }
    
    func testOnRetryGivenPresenterWhenOnRetryThenShowLoadingAndFetchExchanges() async {
        mockMapper.mockMappedExchanges = expectedExchanges
        mockInteractor.mockExchanges = mockExchanges
        
        presenter.onRetry()
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        await MainActor.run {
            XCTAssertTrue(mockView.showLoadingCalled)
            XCTAssertTrue(mockInteractor.fetchExchangesCalled)
            XCTAssertEqual(mockInteractor.forceRefresh, false)
            XCTAssertEqual(mockView.viewModelPassed, expectedExchanges)
            XCTAssertTrue(mockView.showExchangesCalled)
        }
    }
    
    func testViewWillAppearTimer() {
        presenter.viewWillAppear()
        
        XCTAssertEqual(mockTimer.invalidateCallCount, 1)
        XCTAssertEqual(mockTimer.scheduleCallCount, 1)
        XCTAssertTrue(mockTimer.isRunning)    }
    
    func testViewWillAppearResponse() async {
        mockMapper.mockMappedExchanges = expectedExchanges
        mockInteractor.mockExchanges = mockExchanges
        
        presenter.viewWillAppear()
        mockTimer.fire()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        await MainActor.run {
            XCTAssertFalse(mockView.showLoadingCalled)
            XCTAssertTrue(mockInteractor.fetchExchangesCalled)
            XCTAssertEqual(mockInteractor.forceRefresh, false)
            XCTAssertEqual(mockView.viewModelPassed, expectedExchanges)
            XCTAssertTrue(mockView.showExchangesCalled)
        }
    }
}
