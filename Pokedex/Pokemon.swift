//
//  Pokemon.swift
//  Pokedex
//
//  Created by Alexey Ly on 1/18/16.
//  Copyright © 2016 AlbaSoft. All rights reserved.
//

import Foundation
import Alamofire;


class Pokemon {
    private var _name: String!;
    private var _pokedexId: Int!;
    private var _description: String!;
    private var _type: String!;
    private var _defense: String!;
    private var _height: String!;
    private var _weight: String!;
    private var _attack: String!;
    private var _nextEvoTxt: String!;
    private var _pokemonUrl: String!;
    
    
    var name: String {
        return _name;
    }
    
    var pokedexId: Int {
        return _pokedexId;
    }
    
    var type: String {
        return _type;
    }
    
    var description: String {
        return _description;
    }
    
    var nexEvo: String {
        return _nextEvoTxt;
    }
    
    
    init(name: String, pokedexId: Int) {
        _name = name;
        _pokedexId = pokedexId;
        
        _pokemonUrl = URL_BASE + URL_POKEMON + "\(self._pokedexId)/";
    }
    
    func downloadPokeDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!;
        Alamofire.request(.GET, url).responseJSON { (response: Response<AnyObject, NSError>) -> Void in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight;
                }
                
                if let height = dict["height"] as? String {
                    self._height = height;
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = attack.description;
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = defense.description;
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString;
                    }
                    for (var i = 1; i < types.count; ++i) {
                        if let name = types[i]["name"] {
                            self._type! += "/" + name.capitalizedString;
                        };
                    }
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let uri = descArr[0]["resource_uri"] {
                        let descUrl = URL_BASE + uri;
                        let url = NSURL(string: descUrl)!;
                        Alamofire.request(.GET, url).responseJSON(completionHandler: { (response: Response<AnyObject, NSError>) -> Void in
                            print(response.result.value);
                            
                            if let descArr = response.result.value as? Dictionary<String, AnyObject> {
                                if let descText = descArr["description"] as? String {
                                    print(descText);
                                    self._description = descText;
                                    completed();
                                }
                            }
                        })
                        
                    }
                } else {
                    self._description = "";
                }
                
                if let evolArr = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolArr.count > 0 {
                    if let evoTo = evolArr[0]["to"] as? String {
                        self._nextEvoTxt = evoTo;
                    }
                } else {
                    self._nextEvoTxt = "";
                }
                
                print(self._weight);
                print(self._height);
                print(self._attack);
                print(self._defense);

                print(self._type);
            } else {
                self._type = "";
            }
        };
    }
}