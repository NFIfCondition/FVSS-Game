//
//  Joystick.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 10.04.21.
//

import Foundation
import SpriteKit


class Joystick: SKNode{
    
    // Eigenschaften
    let joystick =  SKShapeNode()
    let stick = SKShapeNode()
    
    let maxRange: CGFloat = 50
    
    var xValue: CGFloat = 0
    var yvalue:CGFloat = 0
    
    
    
    // Methoden
    func showJoystick(touch: UITouch) {
        isHidden = false
        position = touch.location(in: parent!)
    }
    
    func moveJoystick(touch: UITouch) {
        let p = touch.location(in: self)
        let x = p.x.clamped(-maxRange, maxRange)
        let y = p.y.clamped(-maxRange, maxRange)
        
        stick.position = CGPoint(x: x, y: y)
        xValue = x / maxRange
        yvalue = y / maxRange
    }
    
    func hideJoystick() {
        isHidden = true
        stick.position = CGPoint.zero
        xValue = 0
        yvalue = 0
    }
    
    // init
    override init() {
        // Joystick selbst
        let joystick = SKShapeNode(circleOfRadius: 100)
        joystick.lineWidth = 2
        joystick.strokeColor = SKColor(white: 1, alpha: 0.5)
        joystick.fillColor = SKColor.gray
        
        
        
        // Stick selbst
        let stick = SKShapeNode(circleOfRadius: 30)
        stick.fillColor = SKColor.black
        stick.lineWidth = 2
        stick.strokeColor = SKColor(white: 0, alpha: 0.5)
        
        super.init()
        
        addChild(joystick)
        joystick.addChild(stick)
        
        isHidden = false
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CGFloat {
    
    public func clamped(_ v1: CGFloat, _ v2: CGFloat) -> CGFloat {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
    
    public mutating func clamp(v1: CGFloat, _ v2: CGFloat) -> CGFloat {
        self = clamped(v1, v2)
        return self
    }
    
    
}
