//
//  SwiftyOptions.swift
//  SwiftyEndpoint
//
//  Created by Baris Cem Baykara on 01.02.2025.
//
import Foundation

/// A protocol that defines a type capable of generating a `URLQueryItem`.
///
/// Conforming types can provide a method to create a `URLQueryItem`, which is used
/// to construct query parameters for URLs in a type-safe and reusable way.
public protocol SwiftyOptions {
	
	/// Creates a `URLQueryItem` from the conforming type.
	///
	/// This method is used to convert the conforming type into a `URLQueryItem`,
	/// which can be added to the query parameters of a URL.
	///
	/// - Returns: A `URLQueryItem` representing the query parameter.
	///
	/// ## Example
	/// ```swift
	/// enum SearchOptions: SwiftyOptions {
	///     case query(String)
	///     case page(Int)
	///     case region(String)
	///
	///     func makeQueryItem() -> URLQueryItem {
	///     	switch self {
	///     		case .query(let value): URLQueryItem(name: "query", value: value)
	///     		case .page(let value): URLQueryItem(name: "page", value: String(value))
	///     		case .region(let value): URLQueryItem(name: "region", value: value)
	///     	}
	///     }
	/// }
	///
	/// // Usage
	/// let searchOptions: [SearchOptions] = [.query("My Query"), .page(2)]
	/// ```
	func toQueryParameter() -> URLQueryItem
}
