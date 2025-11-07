import SwiftUI
import ARKit
import SceneKit

struct ARPortalView: UIViewRepresentable {
    
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
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
}
