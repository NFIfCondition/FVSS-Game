//
//  GameScene.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 25.03.21.
//

import SpriteKit

var loaded: Bool = false
var charakter: String = " "

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


//INGAME SCENE
class ingame: SKScene{
    
    func checkUserCharakter() -> String{
        var charakter: String = "invalid"
        //insert charakter name (edison, Tesla)
        //else dont switch
        
        
        return charakter
    }
    
    override func didMove(to view: SKView) {
        if checkUserCharakter() != "invalid" {
            charakter = checkUserCharakter()
        } else {
            //send to create a charakter
                let ingame = newCharakter(size: self.size)
                let animation = SKTransition.fade(with: SKColor.red, duration: 3)
                self.view?.presentScene(ingame, transition: animation)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}

//CREATE CHARAKTRE SCENE
class newCharakter: SKScene{
    
    //Charakter auswählen UI
    //insert into database
    
    override func didMove(to view: SKView) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
}
