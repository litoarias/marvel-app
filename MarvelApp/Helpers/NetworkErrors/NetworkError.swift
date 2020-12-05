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
