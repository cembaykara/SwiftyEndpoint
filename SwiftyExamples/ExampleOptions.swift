//
//  ExampleOptions.swift
//  SwiftyEndpoint
//
//  Created by Baris Cem Baykara on 01.02.2025.
//
import Foundation
import SwiftyEndpoint

enum MockMoviesOptions: SwiftyOptions {
	case region(String)
	case page(Int)
	
	func toQueryParameter() -> URLQueryItem {
		switch self {
			case .region(let value): URLQueryItem(name: "region", value: value)
			case .page(let value): URLQueryItem(name: "page", value: String(value))
		}
	}
}

extension MockMoviesOptions: Equatable {
	
	static func == (lhs: MockMoviesOptions, rhs: MockMoviesOptions) -> Bool {
		switch (lhs, rhs) {
			case (.region(let lhsValue), .region(let rhsValue)):
				return lhsValue == rhsValue
			case (.page(let lhsValue), .page(let rhsValue)):
				return lhsValue == rhsValue
			default:
				return false
		}
	}
}
