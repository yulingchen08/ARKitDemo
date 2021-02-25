//
//  BirdType.swift
//  ARKitDemo
//
//  Created by Eric Chen 陳鈺翎 on 2021/2/21.
//

import Foundation
import SpriteKit

enum BirdType {
    case fat
    //case blue
    //case grumpy
    case flying
        
    var prefix: String {
        switch self {
        case .fat: return "fat-bird"
        //case .blue: return "blue-bird"
        //case .grumpy: return "grumpy-bird"
        case .flying: return "flying-monster"
        }
    }
    
    static func chooseType(with number: Int) -> BirdType {
        if number % 2 == 0 {
            return .fat
        }
        return .flying
    }
    
    func keyFrames() -> [SKTexture] {
        var textures: [SKTexture] = []
        for index in 1...8 {
            //let textture = SKTexture(imageNamed: "bird")
            textures.append(SKTexture(imageNamed: "\(self.prefix)-\(index)"))
        }
        return textures
    }
}
