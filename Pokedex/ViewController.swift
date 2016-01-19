//
//  ViewController.swift
//  Pokedex
//
//  Created by Alexey Ly on 1/18/16.
//  Copyright © 2016 AlbaSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                    UICollectionViewDelegate,
                    UICollectionViewDataSource,
                    UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var collection: UICollectionView!;
    
    var _pokemon = [Pokemon]();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self;
        collection.dataSource = self;
        
        parsePokemonCSV();
    }
    
    func parsePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!;
        let csv = CSV(url: path);
        let rows = csv.rows;

        for row in rows {
            let pokeId = Int(row["id"]!)!;
            let name = row["identifier"]!;
            let poke = Pokemon(name: name, pokedexId: pokeId);
            _pokemon.append(poke);
        }
    }

    
    // MARK: - Delegate
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _pokemon.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 105, height: 105);
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let poke = _pokemon[indexPath.row];
            cell.configureCell(poke);
            return cell;
        }
        return UICollectionViewCell();
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
}

