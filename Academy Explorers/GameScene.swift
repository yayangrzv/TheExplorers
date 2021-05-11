//
//  GameScene.swift
//  Academy Explorers
//
//  Created by Yayang Rahmadina on 04/05/21.
//

import Foundation
import SpriteKit

enum GameSceneState {
    case active, gameOver
}

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var playerNode, explorerMates: SKSpriteNode!
    var techTable: SKSpriteNode!
    var buttonJoin: ButtonDiscussion!
    
    var gameState: GameSceneState = .active
    
    override func didMove(to view: SKView) {
        //playerlist
        playerNode = childNode(withName: "player") as? SKSpriteNode
        addExplorers(2)
        
        techTable = childNode(withName: "techTable") as? SKSpriteNode
        techTable.name = "techTable"
        
//        buttonJoin = (self.childNode(withName: "buttonJoin") as! ButtonDiscussion)
//        buttonJoin.selectedHandler = {
//            /* Grab reference to our SpriteKit view */
//            print("hello, i'm touched")
//              //let skView = self.view as SKView?
//
//              /* Load Game scene */
//              //let scene = GameScene(fileNamed:"GameScene") as GameScene?
//
//              /* Ensure correct aspect mode */
//              //scene?.scaleMode = .aspectFill
//
//              /* Restart game scene */
//              //skView?.presentScene(scene)
//
//        }
//
//        buttonJoin.state = .MSButtonNodeStateHidden
        
        playerNode.name = "currentPlayer"
        playerNode.isUserInteractionEnabled = false
        
        /* Set physics contact delegate */
        //physicsWorld.contactDelegate = self
        
    }
    
    func addExplorers(_ amount: Int){
        let wait = SKAction.wait(forDuration: 0.01)
        let generate = SKAction.run {
        let addMates = self.createSprite()
        self.addChild(addMates)
        }
        
        let sequence = SKAction.sequence([wait, generate])
        let repeatAction = SKAction.repeat(sequence, count: amount)
        self.run(repeatAction)
    }
    
    func createSprite()->SKSpriteNode{
        let width = 60
        let height = 70
        
        let explorerMates = playerNode.copy() as! SKSpriteNode
        explorerMates.name = "explorerMates"
        explorerMates.texture = SKTexture(imageNamed: "explorerMates")
        explorerMates.size = CGSize(width: width, height: height)
        explorerMates.position.x = CGFloat.random(in: -20...20)
        return explorerMates
    }
    
    func randomExplorersPosition() -> CGPoint {
            let xPosition = CGFloat(arc4random_uniform(UInt32((view?.bounds.maxX)! + 1)))
            let yPosition = CGFloat(arc4random_uniform(UInt32((view?.bounds.maxY)! + 1)))
            return CGPoint(x: xPosition, y: yPosition)
        }
    
    func didBegin(_ contact: SKPhysicsContact) {
      /* Hero touches anything, game over */

      
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let action = SKAction.move(to: pos, duration: 1.0)
        // playerSprite is a SpriteKit sprite node.
        playerNode.run(action)
    }
     
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)

            if let name = touchedNode.name
            {
                if name == "currentPlayer"
                {
                    print("Myself is Touched")
                }
                
                if name == "explorerMates"
                {
                    print("My Mate is Touched")
                }
                
                if name == "techTable"
                {
                    /* Show restart button */
                    print("techTable is touched")
                }
                
            
            }
        
        
        for t in touches {
            touchDown(atPoint: t.location(in: self))
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
}
