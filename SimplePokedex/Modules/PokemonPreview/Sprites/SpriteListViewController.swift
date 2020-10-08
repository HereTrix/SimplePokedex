//
//  SpriteListViewController.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/8/20.
//

import UIKit

class SpriteListViewController: UIPageViewController {
    
    fileprivate var pageControl: UIPageControl = {
        let control = UIPageControl()
        
        control.pageIndicatorTintColor = .darkGray
        control.currentPageIndicatorTintColor = .red
        
        return control
    }()
    
    private var spritePlaceholder: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "pokeball")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var sprites: [String] = [] {
        didSet {
            
            pageControl.numberOfPages = sprites.count
            spritePlaceholder.isHidden = sprites.count > 0
            if sprites.count > 0 {
                let preview = self.preview(for: 0)
                setViewControllers([preview],
                                   direction: .forward,
                                   animated: true,
                                   completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        attachPlaceholder()
        attachPageControl()
    }
    
    private func attachPlaceholder() {
        view.addSubview(spritePlaceholder)
        
        spritePlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        spritePlaceholder.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spritePlaceholder.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spritePlaceholder.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func attachPageControl() {
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func preview(for index: Int) -> UIViewController {
        
        let spritePreview = SpriteViewController()
        spritePreview.sprite = sprites[index]
        spritePreview.index = index
        return spritePreview
    }
}

extension SpriteListViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        let index = (viewController as! SpriteViewController).index
        guard index > 0 else {
            return nil
        }
        
        return preview(for: index - 1)
    }

    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let index = (viewController as! SpriteViewController).index
        guard sprites.count - 1 > index else {
            return nil
        }
        return preview(for: index + 1)
    }
}

extension SpriteListViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
        guard let currentPage = viewControllers?.first as? SpriteViewController else {
            return
        }
        
        pageControl.currentPage = currentPage.index
    }
}
