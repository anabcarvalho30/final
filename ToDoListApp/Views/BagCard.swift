//
//  BagCard.swift
//  ToDoListApp
//
//  Created by iredefbmac_31 on 09/01/25.
//

import SwiftUI

struct BagCard: View{
    var oneBag: Bag
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.white)
                .shadow(radius: 4)
                .frame(height: 45)
                .padding(.horizontal, 12)
            
            HStack{
                Text(oneBag.name)
                    .font(Font.custom("Inter", size: 16))
                    .foregroundColor(.black)
                    
                Spacer()
                
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 46, height: 34)
                  .background(oneBag.color)
                  .cornerRadius(6)
            }.padding([.leading, .trailing], 20)
        }
    }
}
 
