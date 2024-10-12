import SwiftUI

struct CustomAlertView: View {
    
    @State var title : String = ""
    @State var message : String
    
    @State var button1 : String = "OK"
    @State var button2 : String = ""
    
    @State var buttonAction :  ((Int) -> ())?
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                // Title
                if (!title.isEmpty){
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                }
                else{
                    Spacer()
                        .frame(height: 10)
                }
                
                if (!message.isEmpty){
                    // Message
                    Text(message)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                // Buttons
                HStack(spacing: 20) {
                    Button(action: {
                        buttonAction?(0)
                    }) {
                        Text(button1)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 40)
                            .background(Color.textDarkBlue)
                            .cornerRadius(10)
                    }
                    
                    if (!button2.isEmpty) {
                        Button(action: {
                            buttonAction?(1)
                        }) {
                            Text(button2)
                                .foregroundColor(.white)
                                .frame(width: 120, height: 40)
                                .background(Color.textDarkBlue)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(width: 300)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5)) // Semi-transparent background
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            print("message", message)
        })
    }
}

//#Preview {
//    CustomAlertView(title :  "" , message: "Testing 123121231 23123123123", button1: "Test", button2:  "Test2")
//}



//import SwiftUI

struct CustomAlertView1: View {
    var title: String
    var message: String
    var button1Title: String
    var button1Action: () -> Void
    var button2Title: String
    var button2Action: () -> Void
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                // Title
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                // Message
                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // Buttons
                HStack(spacing: 20) {
                    Button(action: {
                        button1Action()
                    }) {
                        Text(button1Title)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 40)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        button2Action()
                    }) {
                        Text(button2Title)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 40)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(width: 300)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5)) // Semi-transparent background
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CustomAlertView1(
        title: "Alert Title",
        message: "This is a custom alert message.",
        button1Title: "Cancel",
        button1Action: {
            print("Cancel tapped")
        },
        button2Title: "Confirm",
        button2Action: {
            print("Confirm tapped")
        }
    )
}
