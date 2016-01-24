//
//  PokeDetailViewController.swift
//  Pokedex
//
//  Created by Alexey Ly on 1/22/16.
//  Copyright © 2016 AlbaSoft. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var currentImg: UIImageView!
    @IBOutlet weak var nextImg: UIImageView!
    @IBOutlet weak var nextEvolLvlLbl: UILabel!
    
    
    var _poke: Pokemon!;

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = _poke.name;
        mainImg.image = UIImage(named: _poke.pokedexId.description);
        
        _poke.downloadPokeDetails { () -> () in
            self.typeLbl.text = self._poke.type;
            self.descriptionLbl.text = self._poke.description;
            self.nextEvolLvlLbl.text = self._poke.nexEvo;
        }
    }


    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
