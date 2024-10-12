import SwiftUI

struct ToastView: View {
    @Binding var showToast: Bool
    var message: String
    
    var body: some View {
        if showToast {
            VStack {
                Spacer()
                
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.bottom, 50) // Adjust this for bottom margin
            }
            .frame(maxWidth: .infinity)
            .animation(.easeInOut)
            .transition(.move(edge: .bottom))
            .onAppear {
                // Automatically dismiss the toast after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        showToast = false
                    }
                }
            }
        }
    }
}

struct ToastContentView: View {
    @State private var showToast = false
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    withAnimation {
                        showToast = true
                    }
                }) {
                    Text("Show Toast")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 100)
                
                Spacer()
            }
            
            // ToastView at the bottom
            ToastView(showToast: $showToast, message: "This is a Toast message!")
        }
    }
}

#Preview {
    ToastContentView()
}
