//
//  NetworkError.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case accessTokenNotFound
    case unableToDecode
    case forbidden
    case unauthorized
}
