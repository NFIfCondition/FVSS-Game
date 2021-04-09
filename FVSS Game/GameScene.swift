//
//  GameScene.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 25.03.21.
//

import SpriteKit

var loaded: Bool = false

class GameScene: SKScene {
    
    let loadingImage = SKSpriteNode(imageNamed: "loadingimage")
    
    override func didMove(to view: SKView) {
        loadingImage.size = self.size
        loadingImage.anchorPoint = CGPoint.zero
        self.addChild(loadingImage)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            loaded = true
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if loaded == true{
            let ingame = ingame(size: self.size)
            let animation = SKTransition.fade(with: SKColor.systemBlue, duration: 3)
            self.view?.presentScene(ingame, transition: animation)
        }
    }
    
    func preloadStructs(){
        
    }
}

class ingame: SKScene{
    
    override func didMove(to view: SKView) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}
