//
//  Item.swift
//  ToDoListApp
//
//  Created by iredefbmac_31 on 08/01/25.
//
import Foundation

struct Item: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var data: Date
    var isDone: Bool
}

