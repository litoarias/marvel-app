import XCTest
@testable import MarvelApp

class CharacterDetailViewModelTests: XCTestCase {
	
	var viewModel: CharacterDetailViewModel!
	var client: ClientMock!
	let identifier = 73526
	
	override func setUp() {
		super.setUp()
		client = ClientMock()
		viewModel = CharacterDetailViewModel(client)
	}
	
	override func tearDown() {
		super.tearDown()
		self.client = nil
		self.viewModel = nil
	}
	
	func test_fetchComics() {
		let expComics = expectation(description: "Loading comics")
		expComics.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			expComics.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.comics.value?.data?.results?.count == 75)
	}
	
	func test_fetchEvents() {
		let expEvents = expectation(description: "Loading events")
		expEvents.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			expEvents.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.events.value?.data?.results?.count == 8)
	}
	
	func test_fetchSeries() {
		let expSeries = expectation(description: "Loading series")
		expSeries.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			expSeries.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.series.value?.data?.results?.count == 75)
	}
	
	func test_fetchComicsParseData() {
		let expComics = expectation(description: "Loading comics")
		expComics.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			expComics.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.comics.value?.data?.results != nil)
		XCTAssert(viewModel.comics.value?.data?.results?[0].thumbnail?.thumbnailUrl == "https://i.annihil.us/u/prod/marvel/i/mg/6/60/5e4c1b775f035.jpg")
	}
	
	func test_fetchEventsParseData() {
		let expEvents = expectation(description: "Loading events")
		expEvents.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			expEvents.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.events.value?.data?.results != nil)
		XCTAssert(viewModel.events.value?.data?.results?[0].thumbnail?.thumbnailUrl == "https://i.annihil.us/u/prod/marvel/i/mg/8/f0/51c9ed1304bb7.jpg")
	}
	
	func test_fetchSeriesParseData() {
		let expSeries = expectation(description: "Loading series")
		expSeries.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			expSeries.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.series.value?.data?.results != nil)
		XCTAssert(viewModel.series.value?.data?.results?[0].thumbnail?.thumbnailUrl == "https://i.annihil.us/u/prod/marvel/i/mg/6/10/5d92452f1ab25.jpg")
	}
	
	func test_fetchComicsNoInternetError() {
		let expComcis = expectation(description: "Error comics expectation")
		expComcis.assertForOverFulfill = false
		client = ClientMock()
		client.error = ApiError.noInternet
		viewModel = CharacterDetailViewModel(client)
		viewModel.fetchData(identifier: identifier) {
			expComcis.fulfill()
		}
		waitForExpectations(timeout: 3)
		XCTAssert(viewModel.errorMessage.value == "Internet connection appears offline")
	}
	
}
