//
//  ItemCard.swift
//  ToDoListApp
//
//  Created by iredefbmac_31 on 11/01/25.
//
import SwiftUI

struct ItemCard: View {
    @Binding var isChecked: Bool
    let itemName: String
    let itemDate: Date
    let daysDifference: Int? 
    let toggleCheck: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.white)
                .shadow(radius: 4)
                .frame(width: 310, height: 45)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(itemName)
                        .font(.system(size: 16, weight: .bold))
                    
                    HStack {
                        Text(itemDate.formatted(.dateTime.day().month()))
                            .foregroundStyle(.secondary)
                            .font(.system(size: 14))
                        
                        if let days = daysDifference {
                            Text("- \(days) dias")
                                .foregroundColor(.purple)
                                .font(.system(size: 14, weight: .bold))
                            
                        }
                    }
                }
                Spacer()
                Button {
                    toggleCheck()
                } label: {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.purple)
                }
            }
            .padding([.leading, .trailing], 40)
        }
    }
}
