//
//  SpriteViewController.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/7/20.
//

import UIKit

class SpriteViewController: UIViewController {

    private var imageView: UIImageView = UIImageView()
    
    var sprite: String! {
        didSet {
            imageView.setAsync(image: sprite, placeholder: UIImage(named: "pokeball"))
        }
    }
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attachImageView()
    }
    
    private func attachImageView() {
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}
