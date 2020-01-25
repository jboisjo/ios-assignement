//
//  RepositoryManager.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

protocol RepositoryManagerDelegate {
    func getRepository<T: Codable>(type: T.Type,
                                   _ repoURL: String,
                                   success: @escaping (T) -> Void,
                                   failure: @escaping (NetworkError?) -> Void)
}

class RepositoryManager: RepositoryManagerDelegate {
    let networkManagerDelegate: NetworkManagerDelegate!

    init(networkManagerDelegate: NetworkManagerDelegate) {
        self.networkManagerDelegate = networkManagerDelegate
    }
    
    func getRepository<T>(type: T.Type,
                          _ repoURL: String,
                          success: @escaping (T) -> Void,
                          failure: @escaping (NetworkError?) -> Void) where T : Decodable, T : Encodable {
        
        self.networkManagerDelegate.request(url: repoURL, httpMethod: .GET, data: nil, success: { (response) in
            guard let data = response else { return }

            do {
                let object = try JSONDecoder().decode(type, from: data)
                success(object)
            } catch {
                failure(NetworkError.unableToDecode)
            }
        }) { (error) in
            failure(error)
        }
    }
}
