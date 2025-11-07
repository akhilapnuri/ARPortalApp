import SceneKit
import ARKit

class RoomScene: SCNScene {
    enum RoomType {
        case mainHall
        case classroom
    }
    
    func createRoom(type: RoomType) -> SCNNode {
        // Clear any existing nodes
        self.rootNode.childNodes.forEach { $0.removeFromParentNode() }
        
        // Create the main room node
        let roomNode = SCNNode()
        
        switch type {
        case .mainHall:
            createMainHall(for: roomNode)
        case .classroom:
            createClassroom(for: roomNode)
        }
        
        return roomNode
    }
    
    // MARK: - Main Hall (your existing room)
    private func createMainHall(for roomNode: SCNNode) {
        createWalls(for: roomNode, color: UIColor(red: 0.6, green: 0.9, blue: 0.9, alpha: 1.0))
        createFloor(for: roomNode)
        createCeiling(for: roomNode)
        addBusinessman(to: roomNode)
        addWhiteboard(to: roomNode)
        addLighting(to: roomNode)
    }
    
    // MARK: - Classroom
    // MARK: - Classroom
    private func createClassroom(for roomNode: SCNNode) {
        createWalls(for: roomNode, color: UIColor(red: 0.7, green: 0.9, blue: 0.7, alpha: 1.0)) // Light green
        createFloor(for: roomNode)
        createCeiling(for: roomNode)
        addLighting(to: roomNode)
        
        // ADD RETURN PORTAL TO CLASSROOM
        addReturnPortal(to: roomNode)
    }

    // MARK: - Return Portal
    private func addReturnPortal(to roomNode: SCNNode) {
        // Create a simple portal/doorway for returning to main hall
        let portal = SCNBox(width: 1.5, height: 2.0, length: 0.1, chamferRadius: 0)
        portal.firstMaterial?.diffuse.contents = UIColor.purple.withAlphaComponent(0.7)
        let portalNode = SCNNode(geometry: portal)
        portalNode.position = SCNVector3(0, 0, 1.4) // Position at the front of the room
        portalNode.name = "returnPortal"
        
        roomNode.addChildNode(portalNode)
        
        // Add label text
        let text = SCNText(string: "Return to Main Hall", extrusionDepth: 0.1)
        text.firstMaterial?.diffuse.contents = UIColor.white
        let textNode = SCNNode(geometry: text)
        textNode.scale = SCNVector3(0.02, 0.02, 0.02)
        textNode.position = SCNVector3(-0.7, 0.8, 1.45)
        textNode.name = "returnPortal"
        roomNode.addChildNode(textNode)
    }
    
    // MARK: - Shared Room Components
    private func createWalls(for roomNode: SCNNode, color: UIColor) {
        let roomWidth: Float = 5.0
        let roomHeight: Float = 2.5
        let roomDepth: Float = 3.0
        
        // Back wall
        let backWall = SCNBox(width: CGFloat(roomWidth), height: CGFloat(roomHeight), length: 0.05, chamferRadius: 0)
        backWall.firstMaterial?.diffuse.contents = color
        let backWallNode = SCNNode(geometry: backWall)
        backWallNode.position = SCNVector3(0, 0, -roomDepth/2)
        roomNode.addChildNode(backWallNode)
        
        // Left wall
        let leftWall = SCNBox(width: 0.05, height: CGFloat(roomHeight), length: CGFloat(roomDepth), chamferRadius: 0)
        leftWall.firstMaterial?.diffuse.contents = color
        let leftWallNode = SCNNode(geometry: leftWall)
        leftWallNode.position = SCNVector3(-roomWidth/2, 0, 0)
        roomNode.addChildNode(leftWallNode)
        
        // Right wall
        let rightWall = SCNBox(width: 0.05, height: CGFloat(roomHeight), length: CGFloat(roomDepth), chamferRadius: 0)
        rightWall.firstMaterial?.diffuse.contents = color
        let rightWallNode = SCNNode(geometry: rightWall)
        rightWallNode.position = SCNVector3(roomWidth/2, 0, 0)
        roomNode.addChildNode(rightWallNode)
    }
    
    private func createCeiling(for roomNode: SCNNode) {
        let roomWidth: Float = 5.0
        let roomDepth: Float = 3.0
        
        let ceiling = SCNBox(width: CGFloat(roomWidth), height: 0.05, length: CGFloat(roomDepth), chamferRadius: 0)
        ceiling.firstMaterial?.diffuse.contents = UIColor(red: 0.6, green: 0.9, blue: 0.9, alpha: 1.0) // Default color
        let ceilingNode = SCNNode(geometry: ceiling)
        ceilingNode.position = SCNVector3(0, 1.225, 0)
        roomNode.addChildNode(ceilingNode)
    }
    
    private func createFloor(for roomNode: SCNNode) {
        let roomWidth: Float = 5.0
        let roomDepth: Float = 3.0
        
        let floor = SCNBox(width: CGFloat(roomWidth), height: 0.05, length: CGFloat(roomDepth), chamferRadius: 0)
        floor.firstMaterial?.diffuse.contents = UIColor.brown
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = SCNVector3(0, -1.225, 0)
        roomNode.addChildNode(floorNode)
    }
    
    func addLighting(to roomNode: SCNNode) {
        // Your existing lighting code
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor.white
        ambientLight.intensity = 500
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        roomNode.addChildNode(ambientLightNode)
        
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.color = UIColor.white
        directionalLight.intensity = 500
        let directionalLightNode = SCNNode()
        directionalLightNode.light = directionalLight
        directionalLightNode.eulerAngles = SCNVector3(-Float.pi / 6, 0, 0)
        roomNode.addChildNode(directionalLightNode)
    }
    
    // MARK: - Existing Objects (keep your current code)
    func addBusinessman(to roomNode: SCNNode) {
        // Your existing businessman code
        guard let businessmanScene = SCNScene(named: "business_male_2_low_poly_style.usdz") else {
            print("Error: Could not load businessman model")
            return
        }
        
        let businessmanNode = businessmanScene.rootNode
        businessmanNode.position = SCNVector3(1.2, -1.0, -0.5)
        businessmanNode.scale = SCNVector3(0.01, 0.01, 0.01)
        businessmanNode.eulerAngles = SCNVector3(0, -Float.pi / 4, 0)
        roomNode.addChildNode(businessmanNode)
    }
    
    func addWhiteboard(to roomNode: SCNNode) {
        // Your existing whiteboard code
        guard let whiteboardScene = SCNScene(named: "whiteboard.usdz") else {
            print("Error: Could not load whiteboard model")
            return
        }
        
        let whiteboardNode = whiteboardScene.rootNode
        whiteboardNode.position = SCNVector3(-0.5, -1.0, 0.25)
        whiteboardNode.scale = SCNVector3(0.002, 0.002, 0.002)
        whiteboardNode.name = "whiteboard"
        
        whiteboardNode.enumerateChildNodes { (node, _) in
            node.name = "whiteboard"
            if let geometry = node.geometry {
                for material in geometry.materials {
                    material.lightingModel = .constant
                }
            }
        }
        
        roomNode.addChildNode(whiteboardNode)
    }
}
