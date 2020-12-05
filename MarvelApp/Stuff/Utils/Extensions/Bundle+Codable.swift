import Foundation

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
