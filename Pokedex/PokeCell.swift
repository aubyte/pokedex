//
//  PokeCell.swift
//  Pokedex
//
//  Created by Alexey Ly on 1/18/16.
//  Copyright © 2016 AlbaSoft. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!;
    @IBOutlet weak var nameLbl: UILabel!;
    
    var _pokemon: Pokemon!;
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        layer.cornerRadius = 10;
        layer.shadowColor = UIColor.blackColor().CGColor;
        layer.shadowOffset = CGSize(width: 3, height: 3);
        layer.shadowRadius = 5.0;
        layer.shadowOpacity = 1.0;
    }
    
    func configureCell(pokemon: Pokemon) {
        _pokemon = pokemon;
        nameLbl.text = pokemon.name.capitalizedString;
        thumbImg.image = UIImage(named: "\(pokemon.pokedexId)");
    }
}
