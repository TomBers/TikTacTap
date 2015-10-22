//
//  GameScene.swift
//  TikTacTap
//
//  Created by Tom Berman on 09/06/2014.
//  Copyright (c) 2014 TomB. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
   
   // var cnt = 0;
    var lastTime = CFTimeInterval();
    var cummulativeTime = CFTimeInterval();
    var started = true
    var tapTime = CFTimeInterval()
    var rotations = -1
    
    
    let initialTime = CGFloat(2.0)
    
    var targetTime = CGFloat(2.0)
    
    let goal = SKSpriteNode(imageNamed: "goal.png")
    let target = SKSpriteNode(imageNamed: "target.png")
    let scoreLabel = SKLabelNode()
    
    let info = SKLabelNode()
    
    var error = CGFloat(0.0)
    var deltaError = CGFloat(0.0)
    let vals = NSUserDefaults()
    
    
    override func didMoveToView(view: SKView) {
        
        
        
        
        
        self.backgroundColor = UIColor(red: 1.5, green: 1.5, blue: 1.5, alpha: 1.0)
        
        scoreLabel.fontName = "Ariel"
        scoreLabel.text = "TikTacTap"
        scoreLabel.fontSize = 62
        scoreLabel.fontColor = UIColor.blackColor()
        scoreLabel.position = CGPointMake(frame.midX + 20, frame.maxY - 100)
        
        info.name = "info"
        info.fontName="Ariel"
        info.text = ">"
        info.fontSize = 62
        info.fontColor = UIColor.blackColor()
        
        info.position = CGPointMake(frame.midX+180, frame.maxY-100)
        
        
        
        self.addChild(scoreLabel)
        self.addChild(info)
        
        
        tapTime = CFAbsoluteTimeGetCurrent()
        
        goal.position = CGPointMake(frame.midX, frame.midY)
        self.addChild(goal)
        
        target.position = CGPointMake(frame.midX, frame.midY)
        self.addChild(target)
       

        
       
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */

        let touch : AnyObject!  = touches.anyObject()
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        
        
        if(touchedNode.name){
            if(touchedNode.name == "info"){
//            NSLog("\(touchedNode.name)")
            
            
            let trans = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.4)
            
          
            let infoScene = Info(size: self.scene.size)
            infoScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene.view.presentScene(infoScene,transition: trans)
            }
            
        }
        else{
        
        if(started){
            rotations++
            
//          Find time between taps
            
//            NSLog("Target rotation : \(target.zRotation)")
//            NSLog("Goal rotation : \(goal.zRotation)")
//            NSLog("Diff : \(target.zRotation - goal.zRotation)")
            


                
                error = target.zRotation - goal.zRotation
            
            
//            scoreLabel.text = String(format:"%@%.2f", "Error : ", error)
            scoreLabel.text = String("\(rotations)")
            
            deltaError = abs(error) / 2
//            NSLog("Delta Error : \(deltaError)")
//            NSLog("Target Time : \(targetTime)")
            
            if(targetTime - deltaError > 0){
            targetTime -= deltaError
            }
            else{
                endGame()
            }
        
        
          target.removeAllActions()
        
          goal.zRotation = target.zRotation + CGFloat(M_PI)

        
        var action = SKAction.rotateByAngle(CGFloat(2 * M_PI), duration: NSTimeInterval(targetTime))
        target.runAction(SKAction.repeatAction(action, count:1), completion: endGame)
        }
        
        }
        
    }
    
    func endGame(){
        

        if(rotations > vals.integerForKey("highScore")){
        vals.setInteger(rotations, forKey: "highScore")
        }
        
        started = false
//        scoreLabel.text = "Ended"
        error = 0;
        targetTime = initialTime
        started  = true
        rotations = -1
        target.zRotation = 0
        goal.zRotation = 0//CGFloat(M_PI)
        
       
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        

//        cummulativeTime += (currentTime - lastTime);
//        lastTime = currentTime;
//        
//        if(cummulativeTime > currentTarget){
//            cummulativeTime = 0;
////            NSLog(String(currentTime));
//        }
        
        
        
        
        
        }
}
