//
//  UIImageView+Extensions.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import UIKit

extension UIImageView {
    
    func setAsync(image: String, placeholder: UIImage? = nil) {
        
//        self.image = placeholder
        
        ImageLoader.shared.load(image: image, for: self, placeholder: placeholder)
    }
}
