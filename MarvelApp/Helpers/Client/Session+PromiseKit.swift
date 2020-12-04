//
//  Session+PromiseKit.swift
//  MarvelApp
//
//  Created by Hipolito Arias on 4/12/20.
//

import Alamofire
import PromiseKit

extension Session {
	func request<T: Codable>(_ urlConvertible: APIRouter) -> Promise<T> {
		return Promise<T> { seal in
			request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
				switch response.result {
				case .success(let value):
					seal.fulfill(value)
				case .failure:
					switch response.response?.statusCode {
					case 400:
						seal.reject(ApiError.badAPIRequest)
					case 401:
						if let data = response.data {
							seal.reject(data.getCode())
						} else {
							seal.reject(ApiError.unknown)
						}
					case 403:
						seal.reject(ApiError.forbidden)
					case 404:
						seal.reject(ApiError.notFound)
					case 405:
						seal.reject(ApiError.methodNotAllowed)
					case 409:
						if let data = response.data {
							seal.reject(data.getCode())
						} else {
							seal.reject(ApiError.unknown)
						}
					case 500:
						seal.reject(ApiError.serverDown)
					default:
						if NetworkReachabilityManager()?.isReachable ?? false {
							seal.reject(ApiError.unknown)
						} else {
							seal.reject(ApiError.noInternet)
						}
					}
				}
			}
		}
	}
}
