//
//  GameViewController.swift
//  Agents
//
//  Created by Ramy Al Zuhouri on 01/06/17.
//  Copyright © 2017 Ramy Al Zuhouri. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene:GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene")
        {
            // Get the SKScene from the loaded GKScene
            self.scene = scene.rootNode as! GameScene
            
            // Copy gameplay related content over to the scene
            self.scene.entities = scene.entities
            self.scene.graphs = scene.graphs
            
            // Set the scale mode to scale to fit the window
            self.scene.scaleMode = .aspectFill
            
            // Present the scene
            if let view = self.view as! SKView? {
                view.presentScene(self.scene)
                
                view.ignoresSiblingOrder = true
                
                view.showsFPS = true
                view.showsNodeCount = true
            }
        }
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        self.view.addGestureRecognizer(panRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.view.addGestureRecognizer(tapRecognizer)
        
        let twoFingersTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(twoFingersTap(_:)))
        twoFingersTapRecognizer.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoFingersTapRecognizer)
    }
    
    func twoFingersTap(_ gesture:UITapGestureRecognizer)
    {
        if gesture.state == .ended
        {
            /*let locationInView = gesture.location(in: self.view)
             let locationInScene = self.scene.convertPoint(fromView: locationInView)
             self.scene.twoFingersTap(locationInScene: locationInScene)*/
        }
    }
    
    func tap(_ gesture:UITapGestureRecognizer)
    {
        if gesture.state == .ended
        {
            let locationInView = gesture.location(in: self.view)
            let locationInScene = self.scene.convertPoint(fromView: locationInView)
            self.scene.tap(locationInScene: locationInScene)
        }
    }
    
    func pan(_ gesture:UIPanGestureRecognizer)
    {
        if gesture.state == .ended
        {
            /*let translation = gesture.translation(in: self.view)
             self.scene.pan(translation: CGVector(dx: translation.x, dy: translation.y))*/
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
