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
            let selectCharakter = selectCharakter(size: self.size)
            let animation = SKTransition.fade(with: SKColor.systemBlue, duration: 3)
            self.view?.presentScene(selectCharakter, transition: animation)
        }
    }
    
    func preloadStructs(){
        
    }

}

//CREATE CHARAKTRE SCENE
class selectCharakter: SKScene{
    
    //Charakter auswählen UI
    //in every game u can play Edison or Tesla
    
    override func didMove(to view: SKView) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
}



//INGAME SCENE
class ingame: SKScene{
    
    override func didMove(to view: SKView) {
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}


