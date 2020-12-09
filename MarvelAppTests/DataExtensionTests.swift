import XCTest
@testable import MarvelApp

class DataExtensionTests: XCTestCase {
	
	func testInvalidCredentialsError() {
		let data = Data("{\"code\": \"InvalidCredentials\"}".utf8)
		debugPrint(data.getCode())
		XCTAssert(data.getCode() == ApiError.unauthorized(.invalidCredentials))
	}
	
	func testInvalidRefererError() {
		let data = Data("{\"code\": \"InvalidReferer\"}".utf8)
		debugPrint(data.getCode())
		XCTAssert(data.getCode() == ApiError.unauthorized(.invalidReferer))
	}
	
	func testInvalidHashError() {
		let data = Data("{\"code\": \"InvalidHash\"}".utf8)
		debugPrint(data.getCode())
		XCTAssert(data.getCode() == ApiError.unauthorized(.invalidHash))
	}
}
