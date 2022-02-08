//
//  DownloadImageOperation.swift
//  SpaceX
//
//  Created by Mikita Shalima on 8.02.22.
//

import UIKit

class DownloadImageOperation: Operation {

    var image: UIImage?
    var url: String
    var completion: ((UIImage?) -> Void)?
    
    init(url: String) {
        self.url = url
        super.init()
    }
    
    override func main() {
        
        guard let url = URL(string: self.url) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [self]  (data, response, error) in
            guard let data = data else {
                return
            }
            
            let image = UIImage(data: data)
            self.image = image

            if let completionBlock = self.completion {
                completionBlock(image)
            }
        }
        dataTask.resume()
    }
    
}
