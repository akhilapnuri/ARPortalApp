import SwiftUI

struct WelcomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var currentRoom: RoomScene.RoomType
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header with X button
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                // Content
                VStack(spacing: 25) {
                    Text("Greetings, future financial expert!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    VStack(spacing: 15) {
                        Text("Let me show you how the choices you make today can build a treasure-filled tomorrow.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                        
                        Text("Venture into either The Classroom, The Vault, or The Crystal Ball portals to explore the different features of this app!")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                    
                    // Portal Buttons
                    VStack(spacing: 15) {
                        Button(action: {
                            currentRoom = .classroom
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Enter The Classroom")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        
                        // Add The Vault and Crystal Ball buttons later
                        Button(action: {
                            // Coming soon
                        }) {
                            Text("The Vault (Coming Soon)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(true)
                        
                        Button(action: {
                            // Coming soon
                        }) {
                            Text("The Crystal Ball (Coming Soon)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(true)
                    }
                    .padding(.horizontal, 25)
                }
                
                Spacer()
            }
        }
    }
}
