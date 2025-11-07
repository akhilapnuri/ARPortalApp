import SceneKit
import ARKit

class PortalScene: SCNScene {
    
    func createPortal() -> SCNNode {
        // Clear any existing nodes
        self.rootNode.childNodes.forEach { $0.removeFromParentNode() }
        
        // Create the main room node
        let roomNode = SCNNode()
        
        // Create walls, floor, and ceiling
        createWalls(for: roomNode)
        createFloor(for: roomNode)
        createCeiling(for: roomNode)
        
        // ADD THE BUSINESSMAN
        addBusinessman(to: roomNode)
        
        // ADD THE WHITEBOARD (right after businessman)
        addWhiteboard(to: roomNode)
        
        return roomNode
    }
    
    func createWalls(for roomNode: SCNNode) {
        // Light sky blue color
        let wallColor = UIColor(red: 0.6, green: 0.9, blue: 0.9, alpha: 1.0) // Light teal
        
        let roomWidth: Float = 5.0
        let roomHeight: Float = 2.5
        let roomDepth: Float = 3.0
        
        // Back wall
        let backWall = SCNBox(width: CGFloat(roomWidth), height: CGFloat(roomHeight), length: 0.05, chamferRadius: 0)
        backWall.firstMaterial?.diffuse.contents = wallColor
        let backWallNode = SCNNode(geometry: backWall)
        backWallNode.position = SCNVector3(0, 0, -roomDepth/2)
        roomNode.addChildNode(backWallNode)
        
        // Left wall
        let leftWall = SCNBox(width: 0.05, height: CGFloat(roomHeight), length: CGFloat(roomDepth), chamferRadius: 0)
        leftWall.firstMaterial?.diffuse.contents = wallColor
        let leftWallNode = SCNNode(geometry: leftWall)
        leftWallNode.position = SCNVector3(-roomWidth/2, 0, 0)
        roomNode.addChildNode(leftWallNode)
        
        // Right wall
        let rightWall = SCNBox(width: 0.05, height: CGFloat(roomHeight), length: CGFloat(roomDepth), chamferRadius: 0)
        rightWall.firstMaterial?.diffuse.contents = wallColor
        let rightWallNode = SCNNode(geometry: rightWall)
        rightWallNode.position = SCNVector3(roomWidth/2, 0, 0)
        roomNode.addChildNode(rightWallNode)
    }

    func createCeiling(for roomNode: SCNNode) {
        let roomWidth: Float = 5.0
        let roomDepth: Float = 3.0
        
        let ceilingColor = UIColor(red: 0.6, green: 0.9, blue: 0.9, alpha: 1.0) // Same light teal
        
        let ceiling = SCNBox(width: CGFloat(roomWidth), height: 0.05, length: CGFloat(roomDepth), chamferRadius: 0)
        ceiling.firstMaterial?.diffuse.contents = ceilingColor
        let ceilingNode = SCNNode(geometry: ceiling)
        ceilingNode.position = SCNVector3(0, 1.225, 0)
        roomNode.addChildNode(ceilingNode)
    }
    
    func createFloor(for roomNode: SCNNode) {
        let roomWidth: Float = 5.0  // Match the new width
        let roomDepth: Float = 3.0
        
        let floor = SCNBox(width: CGFloat(roomWidth), height: 0.05, length: CGFloat(roomDepth), chamferRadius: 0)
        floor.firstMaterial?.diffuse.contents = UIColor.brown
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = SCNVector3(0, -1.225, 0)
        roomNode.addChildNode(floorNode)
    }

    
    func addLighting(to roomNode: SCNNode) {
        // Minimal ambient light only - enough to see but not overlight the model
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor.white
        ambientLight.intensity = 500 // Low intensity
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        roomNode.addChildNode(ambientLightNode)
        
        let directionalLight = SCNLight()
            directionalLight.type = .directional
            directionalLight.color = UIColor.white
            directionalLight.intensity = 500 // Extremely low
            let directionalLightNode = SCNNode()
            directionalLightNode.light = directionalLight
            directionalLightNode.eulerAngles = SCNVector3(-Float.pi / 6, 0, 0) // Gentle angle
            roomNode.addChildNode(directionalLightNode)
        
    
    }
    
    func addBusinessman(to roomNode: SCNNode) {
        // Load the 3D model - replace "businessman.usdz" with your actual file name
        guard let businessmanScene = SCNScene(named: "business_male_2_low_poly_style.usdz") else {
            print("Error: Could not load businessman model")
            return
        }
        
        // Get the root node of the model
        let businessmanNode = businessmanScene.rootNode
        
        // Position in the right 20% of the room
        // Room width is 3.0, so right 20% is around x = 1.2 to 1.5
        businessmanNode.position = SCNVector3(1.2, -1.0, -0.5) // Right side, back corner // Adjust Y and Z as needed
        
        // Scale if necessary (models can be too big or small)
        businessmanNode.scale = SCNVector3(0.01, 0.01, 0.01) // Medium // Start small and adjust
        
        
        
        // Add to the room
        roomNode.addChildNode(businessmanNode)
    }
    
    func addWhiteboard(to roomNode: SCNNode) {
        // Load the whiteboard model - replace "whiteboard.usdz" with your actual filename
        guard let whiteboardScene = SCNScene(named: "whiteboard.usdz") else {
            print("Error: Could not load whiteboard model")
            return
        }
        
        let whiteboardNode = whiteboardScene.rootNode
        
        // Position to the LEFT of the businessman
        // Businessman is at x = 1.2, so put whiteboard at x = 0.8 (to the left)
        whiteboardNode.position = SCNVector3(-0.5, -1.0, 0.25) // Same Y and Z as businessman
        
        // Scale - start small and adjust
        whiteboardNode.scale = SCNVector3(0.002, 0.002, 0.002)
        
        // Apply the same lighting fix to prevent overlighting
        whiteboardNode.enumerateChildNodes { (node, _) in
            if let geometry = node.geometry {
                for material in geometry.materials {
                    material.lightingModel = .constant
                }
            }
        }
        
        roomNode.addChildNode(whiteboardNode)
    }
}
