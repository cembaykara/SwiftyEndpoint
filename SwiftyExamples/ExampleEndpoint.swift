//
//  ExampleEndpoint.swift
//  SwiftyEndpoint
//
//  Created by Baris Cem Baykara on 01.02.2025.
//
import SwiftyEndpoint

enum MockMoviesEndpoint: SwiftyEndpoint {
	
	case mostPopular
	case topRated
	
	static let configuration: MockNetworkConfiguration = MockNetworkConfiguration()
	
	static var basePath: String { "/api/v2" }
	
	var path: String {
		switch self {
			case .mostPopular: "/most_popular"
			case .topRated: "/top_rated"
		}
	}
}

extension MockMoviesEndpoint: Equatable {
	
	static func == (lhs: MockMoviesEndpoint, rhs: MockMoviesEndpoint) -> Bool {
		switch (lhs, rhs) {
			case (.mostPopular, .mostPopular): true
			case (.topRated, .topRated): true
			default: false
		}
	}
}
