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
    
    private static var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 8000
        return cache
    }()
    
    private let callbackQueue = DispatchQueue(label: "com.epam.ImageLoaderQueue")
    private var container: [UIImageView:String] = [:]
    
    private init() {}
    
    func load(image link: String, for view: UIImageView, placeholder: UIImage?) {
        
        if let image = ImageLoader.cache.object(forKey: link as NSString) {
            view.image = image
            return
        }
        
        view.image = placeholder
        
        callbackQueue.sync {
            container[view] = link
        }
        
        guard let url = URL(string: link) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                return
            }
            
            ImageLoader.cache.setObject(image, forKey: link as NSString)
            
            self.callbackQueue.sync {
                
                guard let loadedLink = self.container[view] else {
                    return
                }
                
                if loadedLink == link {
                    self.container[view] = nil
                    DispatchQueue.main.async {
                        view.image = image
                    }
                }
            }
        }
        task.resume()
    }
}
