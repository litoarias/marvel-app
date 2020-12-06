struct NetworkConstants {
	
	static let baseURL = "https://gateway.marvel.com/"
	
	enum Path: String {
		case characters = "v1/public/characters"
	}
	
	enum ParameterKey: String {
		case limit
		case offset
		case apikey
		case timestamp = "ts"
		case hash
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
	
	enum Mock {
		case charactersRequest(Page)
		
		var path: String {
			switch self {
			case .charactersRequest(let page):
				return "characters-offset\(page.offset)-limit\(page.limit)"
			}
		}
	}
}
