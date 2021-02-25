//
//  ViewController.swift
//  ARKitDemo
//
//  Created by Eric Chen 陳鈺翎 on 2021/2/20.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSKViewDelegate
    //無論何時你加入一個新的 ARAnchor 物件，以下 ARSKViewDelegate 協定的方法將會被
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        //let labelNode = SKLabelNode(text: "👾")
        let birdType = BirdType.chooseType(with: number)
        let birdFrames = birdType.keyFrames()
        number = number + 1
        //let textture = SKTexture(imageNamed: "bird")
        let labelNode = SKSpriteNode(texture: birdFrames[0])
        labelNode.size = CGSize(width: labelNode.size.width * 0.1, height: labelNode.size.height * 0.1)
        //labelNode.horizontalAlignmentMode = .center
        //labelNode.verticalAlignmentMode = .center
        
        let flyingAction = SKAction.repeatForever(SKAction.animate(with: birdFrames, timePerFrame: 0.1))
        labelNode.run(flyingAction)
        return labelNode;
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
