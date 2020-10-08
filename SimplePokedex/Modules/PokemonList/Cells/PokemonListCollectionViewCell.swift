//
//  PokemonListCollectionViewCell.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import UIKit

class PokemonListCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "PokemonListCollectionViewCellReuseIdentifier"
    
    @IBOutlet private var iconView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: PokemonListItem) {
        let placeholder = UIImage(named: "pokeball")
        if let imageLink = item.imageLink {
            iconView.setAsync(image: imageLink, placeholder: placeholder)
        } else {
            iconView.image = placeholder
        }
        nameLabel.text = item.name
    }
}
