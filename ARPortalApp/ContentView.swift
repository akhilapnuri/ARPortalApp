import SwiftUI

struct ContentView: View {
    @State private var showWelcomeView = false
    @State private var currentRoom: RoomScene.RoomType = .mainHall
    
    var body: some View {
        ZStack {
            // AR View as background
            ARPortalView(showWelcomeView: $showWelcomeView, currentRoom: currentRoom)
                .edgesIgnoringSafeArea(.all)
            
            // Simple instructions
            VStack {
                Text(roomTitle)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.top, 50)
                
                Spacer()
                
                if currentRoom == .mainHall {
                    Text("Tap the whiteboard to begin!")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.bottom, 100)
                } else {
                    Text("Tap the purple portal to return")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.bottom, 100)
                }
            }
        }
        .sheet(isPresented: $showWelcomeView) {
            WelcomeView(currentRoom: $currentRoom)
        }
        .onAppear {
            // Listen for return portal taps
            NotificationCenter.default.addObserver(forName: NSNotification.Name("ReturnToMainHall"), object: nil, queue: .main) { _ in
                currentRoom = .mainHall
            }
        }
    }
    
    private var roomTitle: String {
        switch currentRoom {
        case .mainHall:
            return "Walk into the blue room!"
        case .classroom:
            return "Welcome to the Classroom!"
        }
    }
}
