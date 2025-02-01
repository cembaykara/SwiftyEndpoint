//
//  SwiftyConfiguration.swift
//  SwiftyEndpoint
//
//  Created by Baris Cem Baykara on 01.02.2025.
//
import Foundation

public protocol SwiftyConfiguration {
	
	var host: String? { get }
	
	var port: Int? { get }
	
	var disableSecureConnection: Bool { get }
	
}
