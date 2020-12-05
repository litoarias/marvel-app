import Alamofire
import  PromiseKit

final class ClientMock: APIProtocol {
	
	var error: ApiError?
	
	func getCharacters(_ page: Page) -> Promise<CharacterResponse> {
		let (promise, seal) = Promise<CharacterResponse>.pending()
		switch error {
		case nil:
			guard let characters = Bundle.parse(fileName: NetworkConstants.Mock.charactersRequest.rawValue, type: CharacterResponse.self) else { fatalError("CharacterResponse is required!") }
			seal.fulfill(characters)
		default:
			seal.reject(error!)
		}
		
		return promise
	}
}

extension Bundle {
	static func parse<T: Decodable>(fileName: String, type: T.Type) -> T? {
		if let url = self.main.url(forResource: fileName, withExtension: "json") {
			do {
				let data = try Data(contentsOf: url)
				let decoder = JSONDecoder()
				let jsonData = try decoder.decode(T.self, from: data)
				return jsonData
			} catch {
				print("error:\(error)")
			}
		}
		return nil
	}
}
