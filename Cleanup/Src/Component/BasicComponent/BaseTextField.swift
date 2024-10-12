//
//  BaseTextField.swift
//  PharmaVision
//
//  Created by Kunal Personl on 15/08/24.
//

import SwiftUI

struct BaseTextField: View {
    
    @State private var previousValue : String = ""
    @Binding var value : String
    var placeHolder : String = ""
    @State var isSecure : Bool = false
    @Binding var error : String
    
    var valueChange: ((String, String) -> Void)?
    var onEditingChanged: ((Bool) -> Void)?
    var onCommit: (() -> Void)?
    
    var body: some View {
        VStack{
            VStack{
                if(isSecure) {
                    SecureField(placeHolder, text: $value)
                        .onChange(of: value) { _ in

                            valueChange?(previousValue,value)
                        }
                        .textContentType(.oneTimeCode)  // Enables OTP autofill

                }
                else{
                    TextField(placeHolder, text: Binding(
                        get: { self.value },
                        set: { newValue in
                            self.previousValue = self.value
                            self.value = newValue
                        }),onEditingChanged: { flag in
                            onEditingChanged?(flag)
                        }, onCommit: {
                            onCommit?()
                        })
                    .onChange(of: value) { _ in

                        valueChange?(previousValue,value)
                    }
                    .autocapitalization(.none)
                    .textContentType(.oneTimeCode)  // Enables OTP autofill

                }
            }
            .frame(height: 35)
            .padding(.horizontal,10)
            .padding(.vertical,7)
            .background(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1))
            .background(Color.white)
            .cornerRadius(8)
            
            if (!error.isEmpty) {
                HStack{
                    Text(error)
                        .foregroundStyle(Color.red)
                        .font(.caption)
                    Spacer()
                }
                    
            }
        }
        
    }
}


struct BaseTextField_Previews: PreviewProvider {
    static var previews: some View {
        BaseTextField(value: .constant("asdasd"), placeHolder: "Test", isSecure: true, error: .constant("Error Message"))
            .previewLayout(.sizeThatFits)
            .frame(width: 320)
    }
}

