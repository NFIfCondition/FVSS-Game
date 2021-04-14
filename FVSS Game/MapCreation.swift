//
//  MapCreation.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 14.04.21.
//

import SpriteKit
//Tile
class Map: SKNode{
    let sprite: SKSpriteNode
    let data: MapData
    
    init(data: MapData) {
        self.data = data
        self.sprite = SKSpriteNode(texture: data.texture)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fehler")
    }
    
}

//TileDATA
class MapData{
    
    let name: String
    let texture: SKTexture
    let mapSet: MapSet
 
    init(name: String, texture: String, mapSet: MapSet) {
        self.name = name
        self.texture = SKTexture(imageNamed: texture)
        self.mapSet = mapSet
        
    }
    
    
}

//Tileet
class MapSet{
    let name: String!
    let mapSize: CGSize!
    var mapData: [MapData]!
    
    init(name: String, mapSize: CGSize) {
        self.name = name
        self.mapSize = mapSize
    }
}

//TileMap
class MapCreation: SKNode{
    //Eigenschaften
    let mapSize: CGSize
    let maxMapSize: Int
    let tileset: MapSet
    var tiles = Array<Array<Map?>>()
    
    init (name: String, mapSize: CGSize, maxMapSize: Int, tileset: MapSet){
        
        self.mapSize = mapSize
        self.maxMapSize = maxMapSize
        self.tileset = tileset
        
        super.init()
        
        self.name = name
     
        for x in 0...(maxMapSize - 1){
            tiles.append(Array(repeating: nil, count: maxMapSize))
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fehler")
    }
    

}
