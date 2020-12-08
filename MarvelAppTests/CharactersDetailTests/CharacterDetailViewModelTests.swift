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
		let exp = expectation(description: "Loading comics")
		exp.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.comics.value?.data?.results?.count == 75)
	}
	
	func test_fetchEvents() {
		let exp = expectation(description: "Loading events")
		exp.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.events.value?.data?.results?.count == 8)
	}
	
	func test_fetchSeries() {
		let exp = expectation(description: "Loading series")
		exp.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.series.value?.data?.results?.count == 75)
	}
	
	func test_fetchComicsParseData() {
		let exp = expectation(description: "Loading comics")
		exp.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.comics.value?.data?.results != nil)
		XCTAssert(viewModel.comics.value?.data?.results?[0].thumbnail?.thumbnailUrl == "https://i.annihil.us/u/prod/marvel/i/mg/6/60/5e4c1b775f035.jpg")
	}
	
	func test_fetchEventsParseData() {
		let exp = expectation(description: "Loading events")
		exp.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.events.value?.data?.results != nil)
		XCTAssert(viewModel.events.value?.data?.results?[0].thumbnail?.thumbnailUrl == "https://i.annihil.us/u/prod/marvel/i/mg/8/f0/51c9ed1304bb7.jpg")
	}
	
	func test_fetchSeriesParseData() {
		let exp = expectation(description: "Loading series")
		exp.assertForOverFulfill = false
		viewModel.fetchData(identifier: identifier) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 1)
		XCTAssert(viewModel.series.value?.data?.results != nil)
		XCTAssert(viewModel.series.value?.data?.results?[0].thumbnail?.thumbnailUrl == "https://i.annihil.us/u/prod/marvel/i/mg/6/10/5d92452f1ab25.jpg")
	}
	
	func test_fetchComicsNoInternetError() {
		let exp = expectation(description: "Error comics expectation")
		exp.assertForOverFulfill = false
		client = ClientMock()
		client.error = ApiError.noInternet
		viewModel = CharacterDetailViewModel(client)
		viewModel.fetchData(identifier: identifier) {
			exp.fulfill()
		}
		waitForExpectations(timeout: 3)
		XCTAssert(viewModel.errorMessage.value == "Internet connection appears offline")
	}
	
}
