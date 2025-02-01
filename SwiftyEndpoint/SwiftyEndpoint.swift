//
//  SwiftyEndpoint.swift
//  SwiftyEndpoint
//
//  Created by Baris Cem Baykara on 01.02.2025.
//
import Foundation

/// A protocol that defines the structure for API endpoints.
///
/// Conforming types can specify a base path, a configuration, and a dynamic path
/// for constructing API endpoints in a type-safe and reusable way.
///
/// - Note: The `Configuration` type must conform to the `SwiftyConfiguration` protocol.
public protocol SwiftyEndpoint {
	
	associatedtype Configuration: SwiftyConfiguration
	
	/// The base configuration for the API.
	///
	/// This provides shared settings for a client configuration, or other
	/// parameters required for making API requests.
	static var configuration: Configuration { get }
	
	/// The base path for this API endpoints.
	///
	/// This is typically the root path or a common prefix for all endpoints.
	/// For example, `"/authentication"`.
	static var basePath: String { get }
	
	/// The path for a specific API endpoint.
	///
	/// This is the relative path that is appended to the `basePath` to form the
	/// complete URL for the endpoint. For example, `"/users"` or `"/posts/{id}"`.
	var path: String { get }
	
}


/// An extension to `SwiftyEndpoint` that provides utilities for constructing URLs.
///
/// This extension adds functionality to generate base URLs and endpoint-specific URLs
/// using the configuration and parameters provided by the conforming type.
public extension SwiftyEndpoint {
	
	/// The host address for the API.
	///
	/// This is derived from the `host` property of the `SwiftyConfiguration`.
	/// If no host is provided, a fatal error is triggered.
	///
	/// - Returns: The host address as a `String`.
	static private var host: String {
		guard let hostUrl = configuration.host else {
			fatalError("No host address was provided. Did you set the `SwiftyConfiguration` correctly?")
		}
		
		return hostUrl
	}
	
	/// The port number for the API, if specified.
	///
	/// This is derived from the `port` property of the `SwiftyConfiguration`.
	///
	/// - Returns: The port number as an `Int`, or `nil` if no port is specified.
	static private var port: Int? {
		return configuration.port
	}
	
	/// Indicates whether a secure connection (HTTPS) is preferred.
	///
	/// This is derived from the `disableSecureConnection` property of the `SwiftyConfiguration`.
	///
	/// - Returns: `true` if a secure connection is preferred, otherwise `false`.
	static private var preferSecureConnection: Bool {
		return !configuration.disableSecureConnection
	}
	
	/// Constructs the base URL for the API using the provided options.
	///
	/// - Parameter parameters: An optional array of `SwiftyOptions` to include as query parameters.
	/// - Returns: A `URL` representing the base URL, or `nil` if the URL cannot be constructed.
	static func baseURL(with options: [any SwiftyOptions]? = nil) -> URL? {
		return newComponent(with: options).url
	}
	
	/// Constructs the full URL for the endpoint using the provided options.
	///
	/// - Parameter parameters: An optional array of `SwiftyOptions` to include as query parameters.
	/// - Returns: A `URL` representing the full endpoint URL, or `nil` if the URL cannot be constructed.
	func url(with options: [any SwiftyOptions]? = nil) -> URL? {
		var component = Self.newComponent(with: options)
		component.path.append(path)
		
		return component.url
	}
	
	/// Constructs a custom URL for the endpoint using the provided options and a custom closure.
	///
	/// - Parameters:
	///   - parameters: An optional array of `SwiftyOptions` to include as query parameters.
	///   - custom: A closure that takes a `URLComponents` object and the endpoint path, and returns a modified `URLComponents` object.
	/// - Returns: A `URL` representing the custom endpoint URL, or `nil` if the URL cannot be constructed.
	func url(with options: [any SwiftyOptions]? = nil, custom: @escaping (URLComponents, String) -> URLComponents) -> URL? {
		return custom(Self.newComponent(with: options), path).url
	}
	
	/// Creates a new `URLComponents` object using the configuration and options.
	///
	/// - Parameter parameters: An optional array of `SwiftyOptions` to include as query parameters.
	/// - Returns: A `URLComponents` object configured with the host, port, scheme, base path, and query parameters.
	private static func newComponent(with options: [any SwiftyOptions]? = nil) -> URLComponents {
		var component = URLComponents()
		component.scheme = preferSecureConnection ? "https" : "http"
		component.host = Self.host
		component.path = Self.basePath
		
		if let port = Self.port { component.port = port }
		
		guard let parameters = options else { return component }
		
		if parameters.isEmpty { return component }
		
		let queryItems: [URLQueryItem] = parameters.compactMap { $0.toQueryParameter() }
		component.queryItems = queryItems
		
		return component
	}
	
}
