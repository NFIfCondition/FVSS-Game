//
//  Joystick.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 10.04.21.
//

import Foundation
import SpriteKit


class Joystick: SKNode{
    
    var joystick = SKShapeNode()
    var stick = SKShapeNode()
    
    let maxRange: CGFloat = 0.1
    
    var xValue: CGFloat = 0
    var yValue: CGFloat = 0
    
    var joystickAction: ((_ x: CGFloat, _ y: CGFloat) -> ())?
    
    override init() {
        
        let joystickRect =  CGRect(x: 0, y: 0, width: 120, height: 120)
        let joystickPath = UIBezierPath(ovalIn: joystickRect)
        
        joystick = SKShapeNode(path: joystickPath.cgPath, centered: true)
        joystick.fillColor = .gray
        joystick.strokeColor = .clear
        
        
        stick.fillColor = .darkGray
        stick.strokeColor = .white
        stick.lineWidth = 4
        
        let stickRect = CGRect(x: 0, y: 0, width: 80, height: 80)
        let stickPath = UIBezierPath(ovalIn: stickRect)
        let stick = SKShapeNode(path: stickPath.cgPath, centered: true)

        
        super.init()
        
        addChild(joystick)
        addChild(stick)
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fehler")
    }
    
    
    func moveJoystick(touch: UITouch){
        let p = touch.location(in: self)
        let x = p.x.clamped(-maxRange, maxRange)
        let y = p.y.clamped(-maxRange, maxRange)
        
        stick.position = CGPoint(x: x, y: y)
        xValue = x / maxRange
        yValue = y / maxRange
        
        if let joystickAction = joystickAction{
            joystickAction(xValue, yValue)
        }
        
    }
    
    
}


extension CGFloat{
    func clamped(_ v1: CGFloat,_ v2: CGFloat) -> CGFloat{
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v1 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
}
