//
//  Bag.swift
//  ToDoListApp
//
//  Created by iredefbmac_31 on 07/01/25.
//

import SwiftUI

struct Bag: Identifiable, Equatable {
    let id = UUID()
    var listOfItens: [Item]
    var name: String
    var color: Color
    var dateOfPurchase: Date

    static func ==(lhs: Bag, rhs: Bag) -> Bool {
        lhs.id == rhs.id
    }
}
