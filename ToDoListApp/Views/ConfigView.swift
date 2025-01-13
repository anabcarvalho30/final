//
//  ConfigView.swift
//  ToDoListApp
//
//  Created by iredefbmac_31 on 09/01/25.
//

import SwiftUI

struct ConfigView: View{
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        List{
            Text("APARÊNCIA")
                .font(Font.custom("Inter", size: 13))
                .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.27))
                .padding(.leading)
            
            HStack{
                Text("MODO ESCURO")
                    .font(Font.custom("Inter", size: 13))
                    .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.27))
                    .padding(.leading)
                
                Toggle("", isOn: $isDarkMode)
                    .padding()
                    .toggleStyle(SwitchToggleStyle(tint: .green))
            }
            
        } .listStyle(.plain)
        .navigationTitle("Tela")

    }
}

#Preview {
    ConfigView()
}
