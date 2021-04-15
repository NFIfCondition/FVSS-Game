//
//  GameScene.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 25.03.21.
//

import SpriteKit

var loaded: Bool = false
var charakter: String = ""

class GameScene: SKScene {
    
    let loadingImage = SKSpriteNode(imageNamed: "loadingimage")
    
    override func didMove(to view: SKView) {
        loadingImage.size = self.size
        loadingImage.anchorPoint = CGPoint.zero
        self.addChild(loadingImage)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            loaded = true
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if loaded == true{
            let selectCharakter = selectCharakter(size: self.size)
            let animation = SKTransition.fade(withDuration: 0.2)
            self.view?.presentScene(selectCharakter, transition: animation)
        }
    }
    
    func preLoadStructs(){
        
    }

}

//CREATE CHARAKTRE SCENE
class selectCharakter: SKScene{
    
    
    
    func send(){
        print("funkt")
    }
    
    //Charakter auswählen UI
    //in every game u can play Edison or Tesla
    let imagecharakter = SKSpriteNode(imageNamed: "charakter")
    
    override func didMove(to view: SKView) {
        let edisonBTN = UIButton.init(type: .system)
        edisonBTN.setTitle("", for: .normal)
        edisonBTN.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        edisonBTN.addTarget(self, action: #selector(edisonbtnClicked(_:)), for: .touchUpInside)
        self.view?.addSubview(edisonBTN)
        
        
        let teslabtn = UIButton.init(type: .system)
        teslabtn.setTitle("", for: .normal)
        teslabtn.frame = CGRect(x: 650, y: 170, width: 250, height: 250)
        teslabtn.addTarget(self, action: #selector(teslabtnClicked(_:)), for: .touchUpInside)
        self.view?.addSubview(teslabtn)
        
        
        
        imagecharakter.size = self.size
        imagecharakter.anchorPoint = CGPoint.zero
        self.addChild(imagecharakter)
    }
    
    @objc func edisonbtnClicked(_: UIButton){
        charakter = "edison"
        print(charakter)
        switchtoIngame()
    }
    
    @objc func teslabtnClicked(_: UIButton){
        charakter = "tesla"
        print(charakter)
        switchtoIngame()
    }
    
    func switchtoIngame(){
        let ingame = ingame(size: self.size)
        let animation = SKTransition.fade(with: .red, duration: 2)
        self.view?.presentScene(ingame, transition: animation)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
}



//INGAME SCENE
class ingame: SKScene{
    
    var ground = SKSpriteNode()
    let choosenCharakter = charakter
    var player = SKSpriteNode()
    
    let velocityMultiplier: CGFloat = 0.12
      
      enum NodesZPosition: CGFloat {
        case joystick
      }
    
      lazy var analogJoystick: AnalogJoystick = {
        let screenSize = UIScreen.main.bounds
            let js = AnalogJoystick(diameter: 100, colors: nil, images: (substrate: #imageLiteral(resourceName: "ausen"), stick: #imageLiteral(resourceName: "innen")))
            js.position = CGPoint(x: screenSize.width * -0.5 + js.radius + 45, y: screenSize.height * -0.5 + js.radius + 45)
            js.zPosition = NodesZPosition.joystick.rawValue
            return js
      }()

    
    override func didMove(to view: SKView) {
        setupJoystick()
        
        player = SKSpriteNode(imageNamed: choosenCharakter)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(player)
        
    }
    
    func setupJoystick() {
          addChild(analogJoystick)
      
          analogJoystick.trackingHandler = { [unowned self] data in
          self.player.position = CGPoint(x: self.player.position.x + (data.velocity.x * self.velocityMultiplier),
                                         y: self.player.position.y + (data.velocity.y * self.velocityMultiplier))
          self.player.zRotation = data.angular
          }}
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    

    
    func insertCharakterIntoGame(){
        
    }

}
