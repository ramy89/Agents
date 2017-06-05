//
//  GameScene.swift
//  Agents
//
//  Created by Ramy Al Zuhouri on 01/06/17.
//  Copyright © 2017 Ramy Al Zuhouri. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var lastUpdateTime : TimeInterval = 0
    
    var spaceship:SKSpriteNode?
    {
        guard let spaceship = self.childNode(withName: "Spaceship") as? SKSpriteNode else {
            return nil
        }
        
        return spaceship
    }
    
    var rocks:[SKSpriteNode]
    {
        var rocks = [SKSpriteNode]()
        self.enumerateChildNodes(withName: "Rock") { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) in
            if let rock = node as? SKSpriteNode
            {
                rocks.append(rock)
                if rock.physicsBody == nil {
                    rock.physicsBody = SKPhysicsBody(circleOfRadius: rock.size.width)
                }
            }
        }
        return rocks
    }
    
    lazy var graph:GKObstacleGraph? =
    {
        guard let spaceship = self.spaceship else { return nil }
        
        let obstacles = SKNode.obstacles(fromNodePhysicsBodies: self.rocks)
        //let obstacles = SKNode.obstacles(fromNodeBounds: self.rocks)
        //let obstacles = [GKPolygonObstacle]()
        let graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: Float(spaceship.size.width))
        return graph
    }()
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        if self.spaceship != nil {
            self.camera?.position = self.spaceship!.position
            /*if let agent = self.spaceship?.entity?.component(ofType: GKAgent2D.self) {
                self.spaceship?.position = CGPoint(vector_float2: agent.position)
            }*/
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    func tap(locationInScene location:CGPoint)
    {
        guard let graph = self.graph else { return }
        guard let spaceship = self.spaceship else { return }
        
        let startNode = GKGraphNode2D(point: vector_float2(withPoint: spaceship.position))
        let endNode = GKGraphNode2D(point: vector_float2(withPoint: location))
        
        graph.connectUsingObstacles(node: startNode)
        graph.connectUsingObstacles(node: endNode)
        
        let path = graph.findPath(from: startNode, to: endNode)
        
        guard path.count > 0 else {
            print("Zero length path")
            return
        }
        
        let goal = GKGoal(toFollow: GKPath(graphNodes: path, radius: Float(spaceship.size.width)) , maxPredictionTime: 1.0, forward: true)
        let behavior = GKBehavior(goal: goal, weight: 1.0)
        let agent = GKAgent2D()
        agent.maxSpeed = 100.0
        agent.delegate = self.spaceship?.entity?.component(ofType: GKSKNodeComponent.self)
        agent.behavior = behavior
        
        graph.remove([startNode, endNode])
        spaceship.entity?.addComponent(agent)
        self.entities = [spaceship.entity!]
    }
}





