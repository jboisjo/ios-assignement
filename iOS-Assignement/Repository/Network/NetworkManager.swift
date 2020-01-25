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
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            failure(NetworkError.forbidden)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
               
        if httpMethod == .POST || httpMethod == .PUT {
            request.httpBody = data
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            guard let data = data else { return } //tofix
            
            switch statusCode {
            case 200..<299:
                DispatchQueue.main.async { //to update
                    success(data)
                }
            default:
                DispatchQueue.main.async { //to update
                    print(error as Any)
                    failure(NetworkError.forbidden)
                }
            }
        }.resume()
        
    }
    
}
