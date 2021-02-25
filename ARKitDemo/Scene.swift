//
//  Scene.swift
//  ARKitDemo
//
//  Created by Eric Chen 陳鈺翎 on 2021/2/20.
//

import SpriteKit
import ARKit

class Scene: SKScene {
    
    override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("In touchesBegan")
        guard let sceneView = self.view as? ARSKView else {
            print("to return")
            return
        }
        //檢查使用者是否觸碰到一個標籤節點
        //Get the location where touched
        if let touchLocation = touches.first?.location(in: self) {
            // if there is a node over there
            if let node = nodes(at: touchLocation).first as? SKSpriteNode {
                let fadeOut = SKAction.fadeOut(withDuration: 1.0)
                node.run(fadeOut) {
                    print("remove node from the parent")
                    node.removeFromParent()
                }
                return
            }
        }
        
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            
            // Create a transform with a translation of 0.2 meters in front of the camera
            // 以相機前平移(translation) 0.2 公尺來建立一個變換(transform)
            var translation = matrix_identity_float4x4
            //這目的是放置一個2D 物件在裝置相機前 0.2 公尺
            translation.columns.3.z = -0.8
            //當平移矩陣設定好後，最後的步驟是以平移矩陣來乘上原來的點(也就是 currentFrame.camera.transform )來計算變換點
            //simd_mul 是內建的函數，用來執行矩陣操作。
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            //當我們計算完目標位置(也就是 transform )，我們建立一個 ARAnchor 物件，並將其加入 AR session 。
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
        }
    }
}
