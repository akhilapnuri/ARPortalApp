import SwiftUI
import ARKit
import SceneKit

struct ARPortalView: UIViewRepresentable {
    @Binding var showWelcomeView: Bool
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        
        // Configure AR session
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        // Run the AR session
        arView.session.run(configuration)
        
        // Create portal scene
        let portalScene = PortalScene()
        arView.scene = portalScene
        
        // Automatically create and position the portal
        let portalNode = portalScene.createPortal()
        portalScene.addLighting(to: portalNode)
        
        // Position portal 2 meters in front of camera
        portalNode.position = SCNVector3(0, 0, -2.0)
        
        // Add the portal to the scene
        arView.scene.rootNode.addChildNode(portalNode)
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        context.coordinator.arView = arView
        context.coordinator.showWelcomeView = $showWelcomeView
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
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
                // Check if we tapped the whiteboard or any of its child nodes
                var currentNode: SCNNode? = result.node
                while currentNode != nil {
                    if currentNode?.name == "whiteboard" {
                        showWelcomeView?.wrappedValue = true
                        return
                    }
                    currentNode = currentNode?.parent
                }
            }
        }
    }
}
