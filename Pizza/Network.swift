//
//  Network.swift
//  Pizza
//
//  Created by Ram Voleti on 20/01/21.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case nilData
    case parsingError
    case unknown
    case temp
}

struct Network {

    static func response<T: Codable>(for url: String, type: T.Type, success: @escaping (_ response: T) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
        let session = URLSession.shared
        guard let url = URL(string: url) else {
            failure(NetworkError.invalidUrl)
            return
        }

        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                failure(error)
            } else {
                guard let data = data else {
                    failure(NetworkError.nilData)
                    return
                }
                do {
                    let model = try JSONDecoder().decode(type, from: data)
                    success(model)
                } catch {
                    failure(NetworkError.parsingError)
                }
            }
        }
        task.resume()
    }
}
