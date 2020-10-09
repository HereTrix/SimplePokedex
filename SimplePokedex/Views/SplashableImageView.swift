//
//  SplashableImageView.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/9/20.
//

import UIKit

class SplashableImageView: UIImageView {

    override var image: UIImage? {
        set {
            if let _ = image,
               let newImage = newValue {
                
                UIView.animate(withDuration: 0.4, delay: 0.3) {
                    self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    self.alpha = 0
                } completion: { _ in
                    self.transform = .identity
                    self.alpha = 1
                    super.image = newImage
                }
            } else {
                super.image = newValue
            }
        }
        
        get {
            return super.image
        }
    }
}
