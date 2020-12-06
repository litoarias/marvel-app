import Foundation

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
	
	var errorDescription: String? {
		switch self {
		case .noInternet:
			return "Internet connection appears offline"
		case .unknown:
			return "The services are down! Please try again later"
		default:
			return "The operation can't be completed"
		}
	}
}

enum UnauthorizedType: String {
	case invalidCredentials = "InvalidCredentials"
	case invalidReferer = "InvalidReferer"
	case invalidHash = "InvalidHash"
}

enum MissingParam: String {
	case missingAPIKey = "Missing API Key"
	case missingHash = "Missing Hash"
	case missingTimestamp = "Missing Timestamp"
}
