//
//  ListViewModel.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation


final class ListViewModel {
    
    //MARK: Variable
    let repositoryManagerDelegate: RepositoryManagerDelegate
    
    //MARK: - Init
    init(repositoryManagerDelegate: RepositoryManagerDelegate) {
        self.repositoryManagerDelegate = repositoryManagerDelegate
    }
    
    //MARK: - Function
    func getPlaylistsFromRepository(success: @escaping (Object?) -> Void,
                                    failure: @escaping (NetworkError?) -> Void) {
        
        repositoryManagerDelegate.getRepository(type: Object.self,
                                                NetworkAPI.getPlaylistUrl,
                                                success: { (response) in
                                                    success(response)
                                                }) { (error) in
                                                    failure(error)}
    }
    
    func getNextPlaylistsFromRepository(nextPageToken: String,
                                        success: @escaping (Object?) -> Void,
                                        failure: @escaping (NetworkError?) -> Void) {
        
        repositoryManagerDelegate.getRepository(type: Object.self,
                                                NetworkAPI.getPlaylistUrl + "&pageToken=\(nextPageToken)",
                                                success: { (response) in
                                                    success(response)
                                                }) { (error) in
                                                    failure(error)}
    }
}
