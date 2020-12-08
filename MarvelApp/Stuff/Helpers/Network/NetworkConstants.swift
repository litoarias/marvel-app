struct NetworkConstants {
	
	static let baseURL = "https://gateway.marvel.com/"
	
	enum Path: String {
		case characters = "v1/public/characters"
		case comics = "comics"
		case series = "series"
		case events = "events"
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
		case charactersResponse(Page)
		case comicsResponse
		case eventsResponse
		case seriesResponse
		
		var path: String {
			switch self {
			case .charactersResponse(let page):
				return "characters-offset\(page.offset)-limit\(page.limit)"
			case .comicsResponse:
				return Path.comics.rawValue
			case .eventsResponse:
				return Path.events.rawValue
			case .seriesResponse:
				return Path.series.rawValue
			}
		}
	}
}
