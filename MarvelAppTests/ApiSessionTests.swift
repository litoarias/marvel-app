import XCTest
@testable import MarvelApp

class ApiSessionTests: XCTestCase {
	
	var viewModel: CharacterListViewModel!
	var client: Client!
	var completion: (Int, NSError?) -> Void = { _,_ in }

	override func setUp() {
		super.setUp()
		client = Client()
		viewModel = CharacterListViewModel(client)
	}
	
	override func tearDown() {
		super.tearDown()
		self.client = nil
		self.viewModel = nil
	}
	
	func test_fetchCharactersPagination() {
		
		let expFirstPage = expectation(description: "Loading characters first page")
		viewModel.fetchCharacters({ _,_ in
			expFirstPage.fulfill()
		})
		waitForExpectations(timeout: 3)
		XCTAssert(viewModel.characters.value?.count == defaultLimit)
		XCTAssert(viewModel.currentPage.offset == defaultLimit)
		
		let expSecondPage = expectation(description: "Loading characters second page")
		viewModel.fetchCharacters({ _,_ in
			expSecondPage.fulfill()
		})
		waitForExpectations(timeout: 3)
		XCTAssert(viewModel.characters.value?.count == defaultLimit)
		XCTAssert(viewModel.currentPage.offset == defaultLimit * 2)
		
		let expThirdPage = expectation(description: "Loading characters third page")
		viewModel.fetchCharacters({ _,_ in
			expThirdPage.fulfill()
		})
		waitForExpectations(timeout: 3)
		XCTAssert(viewModel.characters.value?.count == defaultLimit)
		XCTAssert(viewModel.currentPage.offset == defaultLimit * 3)
		
		let expFourthPage = expectation(description: "Loading characters fourth page")
		viewModel.fetchCharacters({ _,_ in
			expFourthPage.fulfill()
		})
		waitForExpectations(timeout: 3)
		XCTAssert(viewModel.characters.value?.count == defaultLimit)
		XCTAssert(viewModel.currentPage.offset == defaultLimit * 4)
	}
	
	func test_fetchCharactersParseData() {
		let expFirstPage = expectation(description: "Loading characters first page")
		viewModel.fetchCharacters({ _,_ in
			expFirstPage.fulfill()
		})
		waitForExpectations(timeout: 3)
		XCTAssert(viewModel.characters.value?[0].identifier == 1011334)
		XCTAssert(viewModel.characters.value?[0].name == "3-D Man")
		XCTAssert(viewModel.characters.value?[0].desc == "")
		XCTAssert(viewModel.characters.value?[0].modified == "2014-04-29T14:18:17-0400")
		XCTAssert(viewModel.characters.value?[0].resourceURI == "http://gateway.marvel.com/v1/public/characters/1011334")
		XCTAssert(viewModel.characters.value?[0].comics?.items?.count == 12)
		XCTAssert(viewModel.characters.value?[0].series?.items?.count == 3)
		XCTAssert(viewModel.characters.value?[0].stories?.items?.count == 20)
		XCTAssert(viewModel.characters.value?[0].events?.items?.count == 1)
		XCTAssert(viewModel.characters.value?[0].urls?.count == 3)
	}
}
