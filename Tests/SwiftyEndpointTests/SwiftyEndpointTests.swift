import Testing
import Foundation
@testable import SwiftyExamples
@testable import SwiftyEndpoint


let endpoints: [MockMoviesEndpoint] = [.topRated, .mostPopular]
@Test("https://api.example.com/api/v2/[MOVIES_ENDPOINTS]",
	  arguments: [MockMoviesEndpoint.mostPopular])
func testEndpointGeneration(endpoint: MockMoviesEndpoint) async throws {
	
	let url = endpoint.url()
	
	switch endpoint {
		case .topRated:
			#expect(url?.absoluteString == "https://api.example.com/api/v2/top_rated")
		case .mostPopular:
			#expect(url?.absoluteString == "https://api.example.com/api/v2/most_popular")
	}
}

let queryParameters: [[MockMoviesOptions]] = [
	[],
	[.region("en-US")],
	[.page(1)],
	[.region("en-US"), .page(1)]
]

let enpoint: [MockMoviesEndpoint] = [.topRated]
@Test("https://api.example.com/api/v2/top_rated?[PARAM]&[PARAM]",
	  arguments: enpoint, queryParameters)
func testQueryParameters(endpoint: MockMoviesEndpoint, options: [MockMoviesOptions]) async throws {
	
	let url = endpoint.url(with: options)
	
	switch options {
		case []:
			#expect(url?.absoluteString == "https://api.example.com/api/v2/top_rated")
		case [.region("en-US")]:
			#expect(url?.absoluteString == "https://api.example.com/api/v2/top_rated?region=en-US")
		case [.page(1)]:
			#expect(url?.absoluteString == "https://api.example.com/api/v2/top_rated?page=1")
		case [.region("en-US"), .page(1)]:
			#expect(url?.absoluteString == "https://api.example.com/api/v2/top_rated?region=en-US&page=1")
		default : fatalError("Unexpected parameters.")
	}
}
