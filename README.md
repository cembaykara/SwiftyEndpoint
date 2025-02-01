# SwiftyEndpoint

SwiftyEndpoint is a lightweight, protocol-oriented Swift package that helps you build type-safe API endpoints with ease. It provides a clean and flexible way to define your API endpoints, handle configurations, and manage query parameters.

## Installation

##### Swift Package Manager
 You can install the SwiftyEndpoint via Swift Package Manager.
 - In Xcode, install the SwiftyEndpoint by navigating to File > Add Packages
 - And enter the GitHub link:
 ```https://github.com/cembaykara/SwiftyEndpoint.git```

##### With Packages.swift
Add SwiftyEndpoint to your `Package.swift`:

```swift
dependencies: [ 
	.package(url: "https://github.com/cembaykara/SwiftyEndpoint.git", from: "1.0.0")
]
```


## Usage

#### 1. Define Your Configuration

First, create a configuration that conforms to `SwiftyConfiguration`:

```swift
import SwiftyEndpoint

struct NetworkConfiguration: SwiftyConfiguration {
	
	let host: String? = "api.example.com"
	let port: Int?
	let disableSecureConnection: Bool = false
	
	init(port: Int? = nil) {
		self.port = port
	}
}
```


#### 2. Create Your Endpoints

Define your endpoints by conforming to `SwiftyEndpoint`:

```swift
enum MoviesEndpoint: SwiftyEndpoint {
	case mostPopular
	case topRated
	
	static let configuration: NetworkConfiguration = NetworkConfiguration()
	
	static var basePath: String { "/api/v2/movies" }
	
	var path: String {
		switch self {
			case .mostPopular: "/most_popular"
			case .topRated: "/top_rated"
		}
	}
}
```

#### 3. Define Query Parameters (Optional) 

Create query parameters by conforming to `SwiftyOptions`: 

```swift
enum MovieOptions: SwiftyOptions { 
    case page(Int)
    case language(String) 
    
    func toQueryParameter() -> URLQueryItem { 
        switch self { 
            case .page(let value): URLQueryItem(name: "page", value: String(value))
            case .language(let value): URLQueryItem(name: "language", value: value)
            }
        }
    }
```

#### 4. Use Your Endpoints 

```swift 
// Basic usage
let popularMoviesURL = MovieEndpoint.mostPopular.url()
// Result: https://api.example.com/api/v2/movies/most_popular

// With query parameters
let options: [MovieOptions] = [.page(1), .language("en-US") ]
let urlWithParams = MovieEndpoint.popular.url(with: options)
// Result: https://api.example.com/api/v2/movies/most_popular?page=1&language=en-US
```

### Base URL Generation
Generate base URLs without endpoint-specific paths:

```swift
let baseURL = MovieEndpoint.baseURL()
// Result: https://api.example.com/api/v2/movies
```

## Advanced Usage

### Custom URL Construction

You can customize URL construction using the `url(with:custom:)` method: 

```swift
let customURL = endpoint.url(with: options) { components, path in 
    var modified = components
    modified.path = "/custom" + path

    return modified
}
```

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

