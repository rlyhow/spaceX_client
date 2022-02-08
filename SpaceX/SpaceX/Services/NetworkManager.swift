//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import Foundation
import UIKit

class NetworkManager {
    
    private let urlSession = URLSession(configuration: .default)
    private let operationQueue = OperationQueue()
    
    func performGetRequest (urlString: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = urlSession.dataTask(with: url) { (data, responce, error) in
            completionHandler(data, error)
        }
        
        task.resume()
    }
    
    func loadImage(forUrl url: String, completion: @escaping (UIImage?) -> Void) {
        let operation = DownloadImageOperation(url: url)
        operation.completion = { image in
            completion(image)
        }
        operationQueue.addOperation(operation)
    }
    
}
