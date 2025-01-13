//
//  BagViewModel.swift
//  ToDoListApp
//
//  Created by iredefbmac_31 on 09/01/25.
//


import SwiftUI
import CoreData

class BagViewModel: ObservableObject {
    @Published var bagListFix: [Bag] = []
    @Published var bagListAll: [Bag] = [] 
    @Published var isPresentingAddBag: Bool = false
}
