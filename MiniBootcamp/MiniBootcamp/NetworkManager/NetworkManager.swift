//
//  NetworkManager.swift
//  MiniBootcamp
//
//  Created by Kenneth Rizo on 2023-05-26.
//

import Foundation

enum FeedsUrl : String {
    case url = "https://gist.githubusercontent.com/ferdelarosa-wz/0c73ab5311c845fb7dfac4b62ab6c652/raw/6a39cffe68d87f1613f222372c62bd4e89ad06fa/tweets.json"
}

class NetworkManager {
    
    public func getFeeds(url : URL, completion : @escaping (Result<Root, Error>) -> ()) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error
            in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Root.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
