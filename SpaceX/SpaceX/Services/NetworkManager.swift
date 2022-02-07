//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import Foundation

class NetworkManager {
    
    private let urlSession = URLSession(configuration: .default)
    
    func performGetRequest (urlString: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = urlSession.dataTask(with: url) { (data, responce, error) in
            completionHandler(data, error)
        }
        
        task.resume()
    }
    
}
