//
//  URLFactory.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import Foundation

enum URLFactory {
    private static var baseURL: URL {
        return baseURLComponents.url!
    }
    private static let baseURLComponents: URLComponents = {
        let url = URL(string: API.main)!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = []
        return urlComponents
    }()
    
    static func getRequest() -> URLRequest {
        let urlComponents = URLFactory.baseURLComponents
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 3
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
