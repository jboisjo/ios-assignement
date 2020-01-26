//
//  NetworkManager.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation
import UIKit

enum HttpMethod: String {
    case GET
    case PUT
    case POST
}

protocol NetworkManagerDelegate: class {
    func request(url: String, httpMethod: HttpMethod, data: Data?,
                 success: @escaping (Data?) -> Void,
                 failure: @escaping (NetworkError?) -> Void)
}

class NetworkManager: NetworkManagerDelegate {
    func request(url: String,
                 httpMethod: HttpMethod,
                 data: Data?,
                 success: @escaping (Data?) -> Void,
                 failure: @escaping (NetworkError?) -> Void) {
        
        guard let url = URL(string: url) else { return }
        guard let accessToken = UserDefaults.standard.string(forKey: "accessTokenKey") else {
            print("Unable to access token")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            guard let data = data else { return } //tofix
            
            switch statusCode {
            case 200..<299:
                success(data)
            case 401:
                failure(NetworkError.unauthorized)
            case 403:
                failure(NetworkError.forbidden)
             default:
                failure(NetworkError.other)
            }
        }.resume()
        
    }
    
}
