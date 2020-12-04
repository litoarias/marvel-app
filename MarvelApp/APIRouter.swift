//
//  APIRouter.swift
//  MarvelApp
//
//  Created by Hipolito Arias on 4/12/20.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
	
	case getCharacters(Int, Int)
	
	private var method: HTTPMethod {
		switch self {
		case .getCharacters:
			return .get
		}
	}
	
	private var path: String {
		switch self {
		case .getCharacters:
			return NetworkConstants.Path.characters.rawValue
		}
	}
	
	private var parameters: Parameters? {
		switch self {
		case .getCharacters(let limit, let offset):
			return [
				NetworkConstants.ParameterKey.limit.rawValue: limit,
				NetworkConstants.ParameterKey.offset.rawValue: offset,
				NetworkConstants.ParameterKey.apikey.rawValue: credentials.publicApiKey,
				NetworkConstants.ParameterKey.ts.rawValue: credentials.timestamp,
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
