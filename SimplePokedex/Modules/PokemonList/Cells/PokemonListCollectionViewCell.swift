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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.image = nil
    }
    
    func configure(with item: PokemonListItem) {
        iconView.image = nil
        
        let placeholder = UIImage(named: "pokeball")
        if let imageLink = item.imageLink {
            iconView.setAsync(image: imageLink, placeholder: placeholder)
        } else {
            iconView.image = placeholder
        }
        nameLabel.text = item.name
    }
}
