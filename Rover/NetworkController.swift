//
//  NetworkController.swift
//  Rover
//
//  Created by Collin Cannavo on 6/28/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation
class NetworkController : NSObject {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
   @objc static func performRequest(forURL url: URL,
                                    withMethod httpMethodString: String,
                               urlParameters: [String: String]? = nil,
                               body: Data? = nil,
                               completion: ((Data?, Error?) -> Void)? = nil) {
        
    guard let httpMethod = HTTPMethod(rawValue: httpMethodString) else {
        NSLog("Invalid HTTP method \(httpMethodString)")
        completion?(nil, NSError(domain: "RoverError", code: 0, userInfo: nil))
        return
    
    }
    
    let requestURL = self.getURL(byAddingParameters: urlParameters, toURL: url)
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            completion?(data, error)
        }
        dataTask.resume()
    }
    
    static func getURL(byAddingParameters parameters: [String: String]?,
                       toURL url: URL) -> URL {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.flatMap { URLQueryItem(name: $0.0, value: $0.1) }
        guard let url = components?.url else { fatalError("URL is nil") }
        return url
    }
}
