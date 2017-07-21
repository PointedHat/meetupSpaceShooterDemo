//
//  GameScene.swift
//  meetupSpaceShooter
//
//  Created by Stephen Ives on 11/07/2017.
//  Copyright © 2017 Stephen Ives. All rights reserved.
//
// Just a comment


import SpriteKit

enum AlienDirection {
    case up, down, leftThenUp, leftThenDown
}

class GameScene: SKScene {
    
    var timeOfLastMove: CFTimeInterval = 0.0
    var timePerMove: CFTimeInterval = 1.0
    var currentAlienDirection = AlienDirection.up
    var nextAlienMoveDirection = AlienDirection.up
    
    let alienMoveUpDistance = CGVector(dx:0, dy: 25)
    let alienMoveDownDistance = CGVector(dx:0, dy: -25)
    let alienMoveLeftDistance = CGVector(dx:-20, dy: 0)
    
    override func didMove(to view: SKView) {
        let viewFrame = view.frame.size
        print("View's frame is \(viewFrame)")
        let sceneFrame = frame.size
        print("Scene's frame is \(sceneFrame)")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        moveAliensForUpdate(currentTime)
    }
    
    func moveAliensForUpdate(_ currentTime: CFTimeInterval) {
        if (currentTime - timeOfLastMove < timePerMove) {return}
        
        enumerateChildNodes(withName: "//alien") {
            node, stop in
            let alien = node as! SKSpriteNode
            
            switch self.currentAlienDirection {
            case .up:
                alien.run(SKAction.move(by: self.alienMoveUpDistance, duration: 0))
                if alien.frame.maxY >= (node.scene?.size.height)!/2 {
                    self.nextAlienMoveDirection = .leftThenDown
                }
            case .down:
                alien.run(SKAction.move(by: self.alienMoveDownDistance, duration: 0))
                if alien.frame.minY <= -(node.scene?.size.height)!/2 {
                    self.nextAlienMoveDirection = .leftThenUp
                }
            case .leftThenUp, .leftThenDown:
                alien.run(SKAction.move(by: self.alienMoveLeftDistance, duration: 0))
                self.nextAlienMoveDirection = self.currentAlienDirection == .leftThenDown ? .down : .up
            }
        }
        self.timeOfLastMove = currentTime
        if nextAlienMoveDirection != self.currentAlienDirection {
            currentAlienDirection = nextAlienMoveDirection
        }
        
    }
}
