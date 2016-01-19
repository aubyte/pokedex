//
//  ViewController.swift
//  Pokedex
//
//  Created by Alexey Ly on 1/18/16.
//  Copyright © 2016 AlbaSoft. All rights reserved.
//

import UIKit
import AVFoundation;

class ViewController: UIViewController,
                    UICollectionViewDelegate,
                    UICollectionViewDataSource,
                    UICollectionViewDelegateFlowLayout,
                    UISearchBarDelegate
{
    
    @IBOutlet weak var collection: UICollectionView!;
    @IBOutlet weak var searchBar: UISearchBar!
    
    var _pokemon = [Pokemon]();
    var _filteredPokemon = [Pokemon]();
    var _musicPlayer: AVAudioPlayer!;
    var _inSearchMode = false;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self;
        collection.dataSource = self;
        searchBar.delegate = self;
        
        initAudio();
        parsePokemonCSV();
    }
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("WangChungDanceHallDays", ofType: "mp3")!;
        do {
            _musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!);
            _musicPlayer.prepareToPlay();
            _musicPlayer.numberOfLoops = -1;
            _musicPlayer.play();
        } catch let error as NSError {
            print(error.debugDescription);
        }
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
        if (_inSearchMode) {
            return _filteredPokemon.count;
        }
        return _pokemon.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 105, height: 105);
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if (_inSearchMode) {
                poke = _filteredPokemon[indexPath.row];
            } else {
                poke = _pokemon[indexPath.row];
            }
            
            cell.configureCell(poke);
            return cell;
        }
        return UICollectionViewCell();
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    // MARK: - SearchBar Delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        _inSearchMode = searchBar.text != nil && searchBar.text != "";
        if (_inSearchMode) {
            let lower = searchBar.text?.lowercaseString;
            _filteredPokemon = _pokemon.filter({
                $0.name.rangeOfString(lower!) != nil;
            });
        } else {
            view.endEditing(true);
            searchBar.resignFirstResponder();
        }
        collection.reloadData();
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true);
    }
    
    
    // MARK: - Events
    
    @IBAction func musicButtonPressed(sender: UIButton!) {
        if (_musicPlayer.playing) {
            _musicPlayer.pause();
            sender.alpha = 0.3;
        }
        else {
            _musicPlayer.play();
            sender.alpha = 1.0;
        }
    }
}

