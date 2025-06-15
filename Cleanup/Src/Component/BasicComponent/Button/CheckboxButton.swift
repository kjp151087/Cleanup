//
//  CheckboxButton.swift
//  Cleanup
//
//  Created by Kunal Personl on 28/11/24.
//

import SwiftUI

struct CheckboxButton: View {
    @Binding var checked: Bool
    
    var action : ((Bool) -> ())?
    
    var body: some View {
        VStack{
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .resizable()
                .aspectRatio(contentMode: .fit) 
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(checked ? .white: .white)
                .onTapGesture {
                    print("Tap on checkbox")
                    action?(!checked)
                    self.checked.toggle()
                }
        }
        
    }
}

#Preview {
    CheckboxButton(checked: .constant(false))
}
