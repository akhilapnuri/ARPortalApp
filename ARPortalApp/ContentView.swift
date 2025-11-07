import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // AR View as background
            ARPortalView()
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
            }
        }
    }
}
