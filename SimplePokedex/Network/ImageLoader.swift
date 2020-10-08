//
//  ImageLoader.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import UIKit

class ImageLoader {
    
    typealias ImageLoaderCompletion = (UIImage?)->Void
    
    static let shared = ImageLoader()
    
    private static let cache = NSCache<NSString, UIImage>()
    
    private var callbacks: [String:ImageLoaderCompletion] = [:]
    private let callbackQueue = DispatchQueue(label: "com.epam.ImageLoaderQueue")
    
    
    private init() {}
    
    func load(image link: String, completion: @escaping ImageLoaderCompletion) {
        
        if let image = ImageLoader.cache.object(forKey: link as NSString) {
            completion(image)
            return
        }
        
        guard let url = URL(string: link) else {
            completion(nil)
            return
        }
        
        // synchronize callbacks and prevent from side effects in collection view
        callbackQueue.sync {
            callbacks[link] = completion
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            ImageLoader.cache.setObject(image, forKey: link as NSString)
            
            self.callbackQueue.sync {
                let callback = self.callbacks[link]
                callback?(image)
                self.callbacks[link] = nil
            }
        }
        task.resume()
    }
}
