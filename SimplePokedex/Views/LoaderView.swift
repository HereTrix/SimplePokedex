//
//  LoaderView.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/7/20.
//

import UIKit

@IBDesignable
class LoaderView: UIView {

    private let imageView = UIImageView()
    
    private let animationKey = "rotationAnimation"
    
    @IBInspectable var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    override var isHidden: Bool {
        didSet {
            if isHidden {
                stopAnimation()
            } else {
                startAnimation()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attachImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        attachImageView()
        
        imageView.image = image
    }
    
    private func attachImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func startAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = 1
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .infinity

        imageView.layer.add(rotationAnimation, forKey: animationKey)
    }
    
    func stopAnimation() {
        imageView.layer.removeAnimation(forKey: animationKey)
    }
}
