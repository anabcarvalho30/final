//
//  ItemViewModel.swift
//  ToDoListApp
//
//  Created by iredefbmac_31 on 12/01/25.
//

import SwiftUI
import CoreData

class ItemViewModel : ObservableObject{
    @Published var itemListDone: [Item] = [
        Item(name: "Exemplo", data: .now, isDone: true)        ]
        @Published var itemListAll: [Item] = [
            Item(name: "Exemplo", data: .now, isDone: false)
        ]

}
