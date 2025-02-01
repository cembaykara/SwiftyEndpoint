//
//  ExampleConfiguration.swift
//  SwiftyEndpoint
//
//  Created by Baris Cem Baykara on 01.02.2025.
//
import SwiftyEndpoint

struct MockNetworkConfiguration: SwiftyConfiguration {
	
	let host: String? = "api.example.com"
	let port: Int?
	let disableSecureConnection: Bool = false
	
	init(port: Int? = nil) {
		self.port = port
	}
}
