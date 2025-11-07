import SwiftUI
import ARKit
import SceneKit

struct ARPortalView: UIViewRepresentable {
    @Binding var showWelcomeView: Bool
    var currentRoom: RoomScene.RoomType = .mainHall
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        
        // Configure AR session
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        // Run the AR session
        arView.session.run(configuration)
        
        // Create initial room
        updateARScene(arView: arView, roomType: currentRoom)
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        context.coordinator.arView = arView
        context.coordinator.showWelcomeView = $showWelcomeView
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // Update the scene when room type changes
        updateARScene(arView: uiView, roomType: currentRoom)
    }
    
    private func updateARScene(arView: ARSCNView, roomType: RoomScene.RoomType) {
        // Clear existing nodes
        arView.scene.rootNode.childNodes.forEach { $0.removeFromParentNode() }
        
        // Create new room scene based on current room type
        let roomScene = RoomScene()
        let roomNode = roomScene.createRoom(type: roomType)
        
        // Position room 2 meters in front of camera
        roomNode.position = SCNVector3(0, 0, -2.0)
        
        // Add the room to the scene
        arView.scene.rootNode.addChildNode(roomNode)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
        var arView: ARSCNView?
        var showWelcomeView: Binding<Bool>?
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let arView = arView else { return }
            
            let location = gesture.location(in: arView)
            let hitResults = arView.hitTest(location, options: nil)
            
            for result in hitResults {
                var currentNode: SCNNode? = result.node
                while currentNode != nil {
                    if currentNode?.name == "whiteboard" {
                        showWelcomeView?.wrappedValue = true
                        return
                    } else if currentNode?.name == "returnPortal" {
                        // Handle return portal tap - we'll need to communicate this back to ContentView
                        // For now, we'll use a notification or we can modify the architecture
                        NotificationCenter.default.post(name: NSNotification.Name("ReturnToMainHall"), object: nil)
                        return
                    }
                    currentNode = currentNode?.parent
                }
            }
        }
    }
}
