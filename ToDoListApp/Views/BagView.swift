//
//  BagView.swift
//  ToDoListApp
//
//  Created by iredefbmac_31 on 07/01/25.
//

import SwiftUI

struct BagView: View {
    @Binding var bag: Bag
    @State private var itemName: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            header

            addItemField

            ForEach(bag.listOfItens.filter { !$0.isDone }, id: \.id) { item in
                ItemCard(
                    isChecked: Binding(
                        get: { item.isDone },
                        set: { isChecked in toggleCheck(for: item, isChecked: isChecked) }
                    ),
                    itemName: item.name,
                    itemDate: item.data,
                    daysDifference: nil,
                    toggleCheck: { toggleCheck(for: item, isChecked: !item.isDone) }
                )
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            deleteItem(item)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }


            Section(header: Text("DURAÇÃO DO PRODUTO")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.secondary)) {
                    ForEach(bag.listOfItens.filter { $0.isDone }, id: \.id) { item in
                        ItemCard(
                            isChecked: Binding(
                                get: { item.isDone },
                                set: { isChecked in toggleCheck(for: item, isChecked: isChecked) }
                            ),
                            itemName: item.name,
                            itemDate: item.data,
                            daysDifference: nil,
                            toggleCheck: { toggleCheck(for: item, isChecked: !item.isDone) }
                        )
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                deleteItem(item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }

            }
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden(true)
    }
    private func deleteItem(_ item: Item) {
        if let index = bag.listOfItens.firstIndex(where: { $0.id == item.id }) {
            bag.listOfItens.remove(at: index)
        }
    }

    private func toggleCheck(for item: Item, isChecked: Bool) {
        if let index = bag.listOfItens.firstIndex(where: { $0.id == item.id }) {
            bag.listOfItens[index].isDone = isChecked
        }
    }


    private func addItem() {
        guard !itemName.isEmpty else { return }
        let newItem = Item(name: itemName, data: Date(), isDone: false)
        bag.listOfItens.append(newItem)
        itemName = ""
    }

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.purple)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.leading, 10)
            }

            Text(bag.name)
                .font(Font.custom("Inter", size: 20).weight(.semibold))
                .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.27))

            Text(bag.dateOfPurchase.formatted(.dateTime.day().month()))
                .font(Font.custom("Inter", size: 18))
                .foregroundColor(Color(red: 0.34, green: 0.35, blue: 0.36).opacity(0.87))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
        }
        .listRowSeparator(.hidden)
    }

    private var addItemField: some View {
        HStack {
            TextField("Adicionar Item", text: $itemName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(color: .secondary, radius: 3, x: 0, y: 2)

            Button(action: addItem) {
                Image(systemName: "plus")
                    .foregroundColor(.purple)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.trailing, 20)
            }
        }
        .listRowSeparator(.hidden)
    }
    
}
