//
//  GameViewController.swift
//  TikTacTap
//
//  Created by Tom Berman on 09/06/2014.
//  Copyright (c) 2014 TomB. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit


extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks")
        
        var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
        var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
        archiver.finishDecoding()
        return scene
    }
}

class GameViewController: UIViewController {

    let localPlayer = GKLocalPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        localPlayer.authenticateHandler = {(viewController : UIViewController!, error : NSError!) -> Void in
            
            
            if(viewController != nil){
                NSLog("Prob with View Controller")
            }
            else if (self.localPlayer.authenticated){
                NSLog("\(self.localPlayer.description)")
            }
            else{
                NSLog("Error : \(error)")
            }
            
            NSLog("Hello : \(self.localPlayer.playerID)")
            if(self.localPlayer.authenticated){
                NSLog("Hello : \(self.localPlayer.playerID)")
            }
            else{
                NSLog("Not Logged in")
            }
            
            
        }

        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    
        
        
    }

    

