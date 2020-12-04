
import UIKit
import Foundation
import PromiseKit
import Alamofire

class ViewController: UIViewController {
	let apiSession = Session()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red
		
		apiSession.request(.getCharacters).done { (characters: [Character]) in
			debugPrint(characters)
		}.catch { error in
//			switch (error as? ApiError) {
//			case .badAPIRequest: break
//			default:
//				debugPrint(error)
//			}
			debugPrint("")
		}.finally {
			debugPrint("")
		}
	}
	
	
}

struct NetworkConstants {
	
	/// Base URL
	static let baseURL = "https://gateway.marvel.com/"
	
	enum ParameterKey: String {
		case limit = "limit"
		case offset = "offset"
		case apikey = "apikey"
		case ts = "ts"
		case hash = "hash"
	}
	
	/// The keys for HTTP header fields
	enum HTTPHeaderFieldKey: String {
		case authorization = "Authorization"
		case contentType = "Content-Type"
		case acceptType = "Accept"
		case acceptEncoding = "Accept-Encoding"
	}
	
	/// The values for HTTP header fields
	enum HTTPHeaderFieldValue: String {
		case json = "application/json"
	}
}

enum APIRouter: URLRequestConvertible {
	
	// MARK: - Endpoints
	case getCharacters
	
	// MARK: - Properties
	private var method: HTTPMethod {
		switch self {
		case .getCharacters:
			return .get
		}
	}
	
	private var path: String {
		switch self {
		case .getCharacters:
			return "v1/public/characters"
		}
	}
	
	private var parameters: Parameters? {
		switch self {
		case .getCharacters:
			return [
				"limit": 20,
				"offset": 0,
				"apikey": credentials.publicApiKey,
				"ts": credentials.timestamp,
				"hash": credentials.hash
			]
		}
	}
	
	private var body: Parameters? {
		switch self {
		default:
			return nil
		}
	}
	
	// MARK: - Methods
	func asURLRequest() throws -> URLRequest {
		// Construct url
		let url = try NetworkConstants.baseURL.asURL()
		
		// Append path
		var urlRequest = URLRequest(url: url.appendingPathComponent(path))
		
		// Determine HTTP method
		urlRequest.httpMethod = method.rawValue
		
		// Set common headers
		urlRequest.setValue(
			NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
			forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.acceptType.rawValue
		)
		urlRequest.setValue(
			NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
			forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.contentType.rawValue
		)
		
		// Add http body to request
		if let body = body {
			do {
				let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
				urlRequest.httpBody = data
			} catch (_) {
				debugPrint("APIRouter: Failed to parse body into request.")
			}
		}
		
		// Add query parameters to request
		if let parameters = parameters {
			urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
		}
		
		return urlRequest
	}
}

extension Session {
	func request<T: Codable>(_ urlConvertible: APIRouter) -> Promise<T> {
		return Promise<T> { seal in
			request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
				switch response.result {
				case .success(let value):
					seal.fulfill(value)
				case .failure(let error):
					switch response.response?.statusCode {
					case 400:
						seal.reject(ApiError.badAPIRequest)
					case 401:
						switch error.errorDescription {
						case UnauthorizedType.invalidCredentials.rawValue:
							seal.reject(ApiError.unauthorized(.invalidCredentials))
						case UnauthorizedType.invalidReferer.rawValue:
							seal.reject(ApiError.unauthorized(.invalidReferer))
						case UnauthorizedType.invalidHash.rawValue:
							seal.reject(ApiError.unauthorized(.invalidHash))
						default:
							seal.reject(ApiError.unknown)
						}
					case 403:
						seal.reject(ApiError.forbidden)
					case 404:
						seal.reject(ApiError.notFound)
					case 405:
						seal.reject(ApiError.methodNotAllowed)
					case 409:
						switch error.errorDescription {
						case MissingParam.missingAPIKey.rawValue:
							seal.reject(ApiError.badRequest(.missingAPIKey))
						case MissingParam.missingHash.rawValue:
							seal.reject(ApiError.badRequest(.missingHash))
						case MissingParam.missingTimestamp.rawValue:
							seal.reject(ApiError.badRequest(.missingTimestamp))
						default:
							seal.reject(ApiError.unknown)
						}
					case 500:
						seal.reject(ApiError.serverDown)
					default:
						guard NetworkReachabilityManager()?.isReachable ?? false else {
							seal.reject(ApiError.noInternet)
							return
						}
						seal.reject(ApiError.unknown)
					}
				}
			}
		}
	}
}

enum ApiError: Error {
	case noInternet
	case forbidden
	case notFound
	case serverDown
	case badAPIRequest
	case methodNotAllowed
	case badRequest(MissingParam)
	case unauthorized(UnauthorizedType)
	case unknown
}

enum UnauthorizedType: String {
	case invalidCredentials = "InvalidCredentials"
	case invalidReferer = "Invalid Referer"
	case invalidHash = "Invalid Hash"
}

enum MissingParam: String {
	case missingAPIKey = "Missing API Key"
	case missingHash = "Missing Hash"
	case missingTimestamp = "Missing Timestamp"
}
