//
//  GameViewController.swift
//  Swift Crunch
//
//  Created by Artur Jaworski on 05.07.2014.
//  Copyright (c) 2014 brckt. All rights reserved.
//

import UIKit
import SpriteKit

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
    @IBOutlet var firstPlayerSceneView: SKView
    @IBOutlet var secondPlayerSceneView: SKView
    
    @IBOutlet var firstPlayerSceneMask: UIView
    @IBOutlet var secondPlayerSceneMask: UIView
    
    @IBOutlet var firstPlayerText: UILabel
    @IBOutlet var secondPlayerText: UILabel
    
    var timer: NSTimer?
    var roundCounter: Int = 0
    
    var roundTime: NSTimeInterval = 1.0
    var maxRounds: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstPlayerText.transform = CGAffineTransformMakeRotation( M_PI );
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.firstPlayerSceneView as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit
            scene.setUserId(0)
            
            skView.presentScene(scene)
        }
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.secondPlayerSceneView as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit
            scene.setUserId(1)
            
            skView.presentScene(scene)
        }
        
        self.firstPlayerText.text = "Please wait"
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        startGame()
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.toRaw())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func endRound() {
        self.roundCounter++
        setRoundsCountLabels()
        if(self.roundCounter == self.maxRounds) {
            endGame()
        }
    }
    
    func endGame() {
        self.timer!.invalidate()
        
        var scene: GameScene = self.firstPlayerSceneView.scene as GameScene!;
        scene.enabled = false;
        scene = self.secondPlayerSceneView.scene as GameScene!
        scene.enabled = false;
        
        self.firstPlayerSceneMask.hidden = false;
        self.secondPlayerSceneMask.hidden = false;
    }
    
    func startGame() {
        self.firstPlayerSceneMask.hidden = true;
        self.secondPlayerSceneMask.hidden = true;
        
        setRoundsCountLabels()
        
        var scene: GameScene = self.firstPlayerSceneView.scene as GameScene!;
        scene.enabled = true;
        scene = self.secondPlayerSceneView.scene as GameScene!
        scene.enabled = true;
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(self.roundTime, target: self, selector: Selector("endRound"), userInfo: nil, repeats: true)
    }
    
    func setRoundsCountLabels() {
        self.firstPlayerText.text = "\(self.maxRounds-self.roundCounter) rounds left"
        self.secondPlayerText.text = self.firstPlayerText.text
    }
}
