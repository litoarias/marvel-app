import Foundation

extension Data {
	func getCode() -> ApiError {
		if let errorJson = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String: Any],
		   let code = errorJson["code"] as? String {
			switch code {
			case UnauthorizedType.invalidCredentials.rawValue:
				return ApiError.unauthorized(.invalidCredentials)
			case UnauthorizedType.invalidReferer.rawValue:
				return ApiError.unauthorized(.invalidReferer)
			case UnauthorizedType.invalidHash.rawValue:
				return ApiError.unauthorized(.invalidHash)
			case MissingParam.missingAPIKey.rawValue:
				return ApiError.badRequest(.missingAPIKey)
			case MissingParam.missingHash.rawValue:
				return ApiError.badRequest(.missingHash)
			case MissingParam.missingTimestamp.rawValue:
				return ApiError.badRequest(.missingTimestamp)
			default:
				return ApiError.unknown
			}
		}
		return ApiError.unknown
	}
}
