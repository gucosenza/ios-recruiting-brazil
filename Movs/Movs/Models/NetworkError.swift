import Foundation

enum NetworkError {
    case url
    case taskError (error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJson
}
