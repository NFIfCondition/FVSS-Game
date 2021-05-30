//
//  GameScene.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 25.03.21.
//

import SpriteKit
import GameplayKit


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
    let map = SKNode()

    let velocityMultiplier: CGFloat = 0.042

      enum NodesZPosition: CGFloat {
        case joystick
      }
    
    func initMap() {
        addChild(map)
        map.xScale = 0.2
        map.yScale = 0.2
        let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
        let tileSize = CGSize(width: 128, height: 128)
        let columns = 128
        let rows = 128


        let waterTiles = tileSet.tileGroups.first { $0.name == "Water" }
        let grassTiles = tileSet.tileGroups.first { $0.name == "Grass"}
        let sandTiles = tileSet.tileGroups.first { $0.name == "Sand"}
        let cobbleTiles = tileSet.tileGroups.first { $0.name == "Cobblestone"}

        let bottomLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
        bottomLayer.name = "botLayer"

        bottomLayer.fill(with: sandTiles)
        bottomLayer.fill(with: waterTiles)
        bottomLayer.fill(with: grassTiles)
        bottomLayer.fill(with: cobbleTiles)

        map.addChild(bottomLayer)
        
        let noiseMap = makeNoiseMap(columns: columns, rows: rows)

        // create our grass/water layer
        let topLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
        topLayer.name = "topLayer"

        // make SpriteKit do the work of placing specific tiles
        topLayer.enableAutomapping = true

        // add the grass/water layer to our main map node
        map.addChild(topLayer)
        
        let row = 0
        let column = 0
        let location = vector2(Int32(row), Int32(column))
        let terrainHeight = noiseMap.value(at: location)
        
        topLayer.setTileGroup(waterTiles, forColumn: column, row: row)

        
        for column in 0 ..< columns {
            for row in 0 ..< rows {
                let location = vector2(Int32(row), Int32(column))
                let terrainHeight = noiseMap.value(at: location)

                if terrainHeight < 0 {
                    topLayer.setTileGroup(waterTiles, forColumn: column, row: row)
                } else {
                    topLayer.setTileGroup(grassTiles, forColumn: column, row: row)
                }
            }
        }
    }
    
    func makeNoiseMap(columns: Int, rows: Int) -> GKNoiseMap {
        let source = GKPerlinNoiseSource()
        source.persistence = 0.9

        let noise = GKNoise(source)
        let size = vector2(1.0, 1.0)
        let origin = vector2(0.0, 0.0)
        let sampleCount = vector2(Int32(columns), Int32(rows))

        return GKNoiseMap(noise, size: size, origin: origin, sampleCount: sampleCount, seamless: true)
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
        initMap()
        
        player = SKSpriteNode(imageNamed: choosenCharakter)
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(player)
        
        
    }
    
    func setupJoystick() {
          addChild(analogJoystick)
      
          analogJoystick.trackingHandler = { [unowned self] data in
            self.map.position = CGPoint(x: self.map.position.x - (data.velocity.x * self.velocityMultiplier),
                                         y: self.map.position.y - (data.velocity.y * self.velocityMultiplier))
          self.player.zRotation = data.angular
          }}
    
    override func update(_ currentTime: TimeInterval) {
//        print(map.children)
        guard let map = map.childNode(withName: "topLayer") as? SKTileMapNode else {
                fatalError("Background node not loaded")
            }


        let column = map.tileColumnIndex(fromPosition: self.map.position)
        print("Column " + String(column))

        let row = map.tileRowIndex(fromPosition: self.map.position)
        print("Row " + String(row))
        print("X " + String(Int32(player.position.x)))
        print("Y " + String(Int32(player.position.y)))
        print("X Map" + String(Int32(self.map.position.x)))
        print("Y Map" + String(Int32(self.map.position.y)))

            let tile = map.tileDefinition(atColumn: column, row: row)
        
        print(tile?.name)
//        let tileSet = childNode(withName: "Sample Grid Tile Set") as? SKTileSet
//        let tile = tileSet.ti
        
    }
    

    
    func insertCharakterIntoGame(){
        
    }

}
