//
//  SeparatorLine.swift
//  PharmaVision
//
//  Created by Kunal Personl on 10/08/24.
//

import SwiftUI

struct SeparatorLine: View {
    var body: some View {
        VStack(spacing:0) {
        
            
        }
        .frame(height: 1)
        .background(Color.red)
        .padding(0)
    }
}

//#Preview {
//    SeparatorLine()
//}



struct ToggleCheckboxView: View {
    @State private var isChecked: Bool = false

    var body: some View {
        VStack {
            Toggle(isOn: $isChecked) {
                Text("Enable Option")
            }
            .toggleStyle(CheckboxToggleStyle()) // Custom checkbox style (optional)
            
            Text(isChecked ? "Checked" : "Unchecked")
        }
        .padding()
    }
}

// Optional: Custom checkbox toggle style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

struct ToggleCheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleCheckboxView()
    }
}
