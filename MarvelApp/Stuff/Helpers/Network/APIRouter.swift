import Alamofire

enum APIRouter: URLRequestConvertible {
	
	case getCharacters(Page)
	case getComics(Int, Page)
	case getSeries(Int, Page)
	case getEvents(Int, Page)
	
	private var method: HTTPMethod {
		switch self {
		case .getCharacters:
			return .get
		case .getComics:
			return .get
		case .getSeries:
			return .get
		case .getEvents:
			return .get
		}
	}
	
	private var path: String {
		switch self {
		case .getCharacters:
			return NetworkConstants.Path.characters.rawValue
		case .getComics(let id, _):
			return NetworkConstants.Path.characters.rawValue + "/\(id)/" + NetworkConstants.Path.comics.rawValue
		case .getSeries(let id, _):
			return NetworkConstants.Path.characters.rawValue + "/\(id)/" + NetworkConstants.Path.series.rawValue
		case .getEvents(let id, _):
			return NetworkConstants.Path.characters.rawValue + "/\(id)/" + NetworkConstants.Path.events.rawValue
		}
	}
	
	private var parameters: Parameters? {
		switch self {
		case .getCharacters(let page):
			return [
				NetworkConstants.ParameterKey.limit.rawValue: page.limit,
				NetworkConstants.ParameterKey.offset.rawValue: page.offset,
				NetworkConstants.ParameterKey.apikey.rawValue: credentials.publicApiKey,
				NetworkConstants.ParameterKey.timestamp.rawValue: credentials.timestamp,
				NetworkConstants.ParameterKey.hash.rawValue: credentials.hash
			]
		case .getComics(_, let page), .getSeries(_, let page), .getEvents(_, let page):
			return [
				NetworkConstants.ParameterKey.limit.rawValue: page.limit,
				NetworkConstants.ParameterKey.offset.rawValue: page.offset,
				NetworkConstants.ParameterKey.apikey.rawValue: credentials.publicApiKey,
				NetworkConstants.ParameterKey.timestamp.rawValue: credentials.timestamp,
				NetworkConstants.ParameterKey.hash.rawValue: credentials.hash
			]
		}
	}
	
	private var body: Parameters? {
		switch self {
		default: return nil
		}
	}
	
	func asURLRequest() throws -> URLRequest {
		let url = try NetworkConstants.baseURL.asURL()
		var urlRequest = URLRequest(url: url.appendingPathComponent(path))
		urlRequest.httpMethod = method.rawValue
		urlRequest.setValue(
			NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
			forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.acceptType.rawValue
		)
		urlRequest.setValue(
			NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
			forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.contentType.rawValue
		)
		if let body = body {
			do {
				let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
				urlRequest.httpBody = data
			} catch (_) {
				debugPrint("APIRouter: Failed to parse body into request.")
			}
		}
		if let parameters = parameters {
			urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
		}
		
		return urlRequest
	}
}
