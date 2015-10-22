//
//  GameScene.swift
//  TikTacTap
//
//  Created by Tom Berman on 09/06/2014.
//  Copyright (c) 2014 TomB. All rights reserved.
//

import SpriteKit
import WebKit
import UIKit

class Info: SKScene {
    
    let vals = NSUserDefaults()
  
    
    
    
    override func didMoveToView(view: SKView) {
        
        
        self.backgroundColor = UIColor(red: 1.5, green: 1.5, blue: 1.5, alpha: 1.0)
        let info = SKLabelNode()
        info.name = "back"
        info.fontName="Ariel"
        info.text = "<"
        info.fontSize = 62
        info.fontColor = UIColor.blackColor()
        info.position = CGPointMake(frame.midX-180, frame.maxY-100)
        
        let web = SKLabelNode()
        web.name = "web"
        web.fontName="Ariel"
        web.text = "web"
        web.fontSize = 62
        web.fontColor = UIColor.blackColor()
        web.position = CGPointMake(frame.midX+140, frame.maxY-100)
        
        
        
        let leaderboard = SKLabelNode()
        leaderboard.name = "leaderboard"
        leaderboard.fontName="Ariel"
        leaderboard.text = "Leader Board"
        leaderboard.fontSize = 62
        leaderboard.fontColor = UIColor.blackColor()
        
        leaderboard.position = CGPointMake(frame.midX, frame.midY)
        
        
        let highScore = SKLabelNode()
        highScore.name = "leaderboard"
        highScore.fontName="Ariel"
        let hs = vals.integerForKey("highScore")
        highScore.text = "High Score : \(hs)"
        highScore.fontSize = 42
        highScore.fontColor = UIColor.blackColor()
        
        highScore.position = CGPointMake(frame.midX, frame.midY - 110)
        
        self.addChild(web)
        self.addChild(highScore)
        self.addChild(leaderboard)
        self.addChild(info)

        
        
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        let touch : AnyObject!  = touches.anyObject()
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        
        
        if(self.nodeAtPoint(location).name) {
            if(self.nodeAtPoint(location).name == "back"){
                let trans = SKTransition.revealWithDirection(SKTransitionDirection.Right, duration: 0.4)
                let infoScene = GameScene(size: self.scene.size)
                infoScene.scaleMode = SKSceneScaleMode.AspectFill
                self.scene.view.presentScene(infoScene,transition: trans)
            }
            else if(self.nodeAtPoint(location).name == "web"){
//                Load Webview
                NSLog("Web")
                let col = UIColor.redColor()
                let wv = UIView(frame: CGRectMake(0,0,400,400))
                wv.backgroundColor = col
                
                
//                        var url = NSURL(string:"http://www.kinderas.com/")
//                        var req = NSURLRequest(URL:url)
//                        wv.loadRequest(req)
                
                self.view.bringSubviewToFront(wv)
                
                
             
                
            }
            
        }
        
    }
    
  
    
    override func update(currentTime: CFTimeInterval) {

        
        
    }
}
