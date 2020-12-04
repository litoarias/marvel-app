//
//  ViewController.swift
//  MarvelApp
//
//  Created by Hipolito Arias on 4/12/20.
//

import UIKit
import Foundation
import PromiseKit
import Alamofire

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	
}

struct NetworkConstants {
	
	/// Base URL
	static let baseURL = "https:our-api-base-url.com"
	
	/// Parameter Keys
	enum ParameterKey: String {
		// Auth
		case email = "email"
		case password = "password"
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
	case getPosts
	case getPostDetails(id: Int)
	case signIn(email: String, password: String)
	
	// MARK: - Properties
	private var method: HTTPMethod {
		switch self {
		case .getPosts, .getPostDetails:
			return .get
		case .signIn:
			return .post
		}
	}
	
	private var path: String {
		switch self {
		case .getPosts:
			return "api/posts"
		case .getPostDetails(let id):
			return "api/posts/\(id)"
		case .signIn:
			return "api/auth/login"
		}
	}
	
	private var parameters: Parameters? {
		switch self {
		default:
			return nil
		}
	}
	
	private var body: Parameters? {
		switch self {
		case .signIn(let email, let password):
			return [NetworkConstants.ParameterKey.email.rawValue: email,
					NetworkConstants.ParameterKey.password.rawValue: password]
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
		urlRequest.setValue(NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
							forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.acceptType.rawValue)
		urlRequest.setValue(NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
							forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.contentType.rawValue)
		
		// Add http body to request
		if let body = body {
			do {
				let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
				urlRequest.httpBody = data
			} catch (_) {
				print("APIRouter: Failed to parse body into request.")
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
	/// Triggers an HTTPRequest using alamofire with a promise as a return type
	func request<T: Codable>(_ urlConvertible: APIRouter) -> Promise<T> {
		return Promise<T> { seal in
			// Trigger the HTTPRequest using Alamofire
			request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
				// Check result from response and map it the the promise
				switch response.result {
				case .success(let value):
					seal.fulfill(value)
				case .failure:
					// If it's a failure, check status code and map it to my error
					switch response.response?.statusCode {
					case 400:
						seal.reject(MyError.badAPIRequest)
					case 401:
						seal.reject(MyError.unauthorized)
					default:
						guard NetworkReachabilityManager()?.isReachable ?? false else {
							seal.reject(MyError.noInternet)
							return
						}
						seal.reject(MyError.unknown)
					}
				}
			}
		}
	}
}
public enum MyError: Error {
	
	// MARK: - Internal errors
	case noInternet
	
	// MARK: - API errors
	case badAPIRequest
	
	// MARK: - Auth errors
	case unauthorized
	
	// MARK: - Unknown errors
	case unknown
}
