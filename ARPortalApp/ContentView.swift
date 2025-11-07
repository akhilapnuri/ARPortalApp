import SwiftUI

struct ContentView: View {
    @State private var showWelcomeView = false
    
    var body: some View {
        ZStack {
            // AR View as background
            ARPortalView(showWelcomeView: $showWelcomeView)
                .edgesIgnoringSafeArea(.all)
            
            // Simple instructions
            VStack {
                Text("Walk into the blue room!")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.top, 50)
                
                Spacer()
                
                Text("Tap the whiteboard to begin!")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.bottom, 100)
            }
        }
        .sheet(isPresented: $showWelcomeView) {
            WelcomeView()
        }
    }
}
