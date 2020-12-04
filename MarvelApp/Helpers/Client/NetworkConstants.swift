
struct NetworkConstants {
	
	static let baseURL = "https://gateway.marvel.com/"
	
	enum Path: String {
		case characters = "v1/public/characters"
	}
	
	enum ParameterKey: String {
		case limit = "limit"
		case offset = "offset"
		case apikey = "apikey"
		case ts = "ts"
		case hash = "hash"
	}
	
	enum HTTPHeaderFieldKey: String {
		case authorization = "Authorization"
		case contentType = "Content-Type"
		case acceptType = "Accept"
		case acceptEncoding = "Accept-Encoding"
	}
	
	enum HTTPHeaderFieldValue: String {
		case json = "application/json"
	}
}
