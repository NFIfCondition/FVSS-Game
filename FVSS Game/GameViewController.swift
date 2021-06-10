//
//  GameViewController.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 25.03.21.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        
        let loadingscene = GameScene(size: self.view.bounds.size)
        let skview = self.view as! SKView        
        
        loadingscene.scaleMode = .aspectFill

        loadingscene.size = skview.bounds.size
        
        
        skview.presentScene(loadingscene)
    }
}
