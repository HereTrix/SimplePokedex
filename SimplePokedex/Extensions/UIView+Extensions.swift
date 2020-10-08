//
//  UIView+Extensions.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import UIKit

extension UIView {
    
    static var nib: UINib {
        let nibName = String(describing: self)
        
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
