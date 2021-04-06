//
//  GameScene.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 25.03.21.
//

import SpriteKit

class GameScene: SKScene {
    
    let loadingImage = SKSpriteNode(imageNamed: "loadingimage")
    
    override func didMove(to view: SKView) {
        
        loadingImage.anchorPoint = CGPoint.zero
        loadingImage.position = CGPoint.zero
        loadingImage.size = self.size
        loadingImage.zPosition = -1
        self.addChild(loadingImage)
        
    }
}
