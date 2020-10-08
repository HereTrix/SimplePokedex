//
//  PokemonCharacteristicTableViewCell.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/7/20.
//

import UIKit

class PokemonCharacteristicTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PokemonCharacteristicTableViewCell"
    
    @IBOutlet private var characteristicNameLabel: UILabel!
    @IBOutlet private var characteristicValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with characteristic: Characteristic) {
        characteristicNameLabel.text = characteristic.name.uppercased()
        characteristicValueLabel.text = characteristic.value
    }
}
