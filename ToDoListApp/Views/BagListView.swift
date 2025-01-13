//
//  ContentView.swift
//  ToDoListApp
//
//  Created by iredefbmac_31 on 09/12/25
//

import SwiftUI
import SwiftData

enum Theme {
    static let primary = Color("Primary")
}
struct BagListView: View {
    @StateObject var bagViewModel = BagViewModel()
    @State private var selectedBag: Bag? = nil
    @State private var isShowingBagView: Bool = false
    @State private var isShowingDeleteAlert: Bool = false
    @State private var bagToDelete: Bag? = nil

    var body: some View {
        NavigationView {
            List {
                headerView

                newPurchaseView

                if !bagViewModel.bagListFix.isEmpty {
                    fixedBagsSection
                }

                if !bagViewModel.bagListAll.isEmpty {
                    shoppingListsSection
                }
            }
            .listStyle(.plain)
            .alert("Deletar Lista?", isPresented: $isShowingDeleteAlert, actions: {
                            Button("Cancelar", role: .cancel) {
                                bagToDelete = nil // Cancela a exclusão
                            }
                            Button("Deletar", role: .destructive) {
                                deleteBag() // Confirma a exclusão
                            }
                        }, message: {
                            Text("Tem certeza que deseja deletar a lista de compras \"\(bagToDelete?.name ?? "")\"?")
                        })
            .sheet(isPresented: $bagViewModel.isPresentingAddBag) {
                AddBagSheet(bagViewModel: bagViewModel)
            }
        }
    }
}

extension BagListView {
    // MARK: - Views
    private var headerView: some View {
        ZStack {
            Image("ReStock")
                .frame(maxWidth: .infinity)
            NavigationLink(destination: ConfigView()) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.purple)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.system(size: 20, weight: .bold))
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    private var newPurchaseView: some View {
        HStack {
            Text("NOVA COMPRA")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.secondary)
            Spacer()
            Button {
                bagViewModel.isPresentingAddBag = true
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.purple)
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .listRowSeparator(Visibility.hidden)
        .padding(.horizontal, 20)
    }

    private var fixedBagsSection: some View {
        Section(header: Text("Compras Fixas")
            .font(.system(size: 13, weight: .bold))
            .foregroundStyle(.secondary)
            .padding(.leading, 20)) {
            ForEach(bagViewModel.bagListFix) { bag in
                NavigationLink(destination: BagView(bag: bindingFor(bag))) {
                    BagCard(oneBag: bag)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        showDeleteAlert(bag: bag)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)

                    Button {
                        unfixBag(bag: bag) // Chamando unfixBag aqui
                    } label: {
                        Label("Unfix", systemImage: "pin.slash")
                    }
                    .tint(.blue)
                }
            }
            .listRowSeparator(Visibility.hidden)
        }
    }


    private var shoppingListsSection: some View {
        Section(header: Text("Listas de Compras")
            .font(.system(size: 13, weight: .bold))
            .foregroundStyle(.secondary)
            .padding(.leading, 20)
           ) {
            ForEach(bagViewModel.bagListAll) { bag in
                NavigationLink(destination: BagView(bag: bindingFor(bag))) {
                    BagCard(oneBag: bag)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        showDeleteAlert(bag: bag)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)

                    Button {
                        moveBagToFix(bag: bag)
                    } label: {
                        Label("Fix", systemImage: "pin")
                    }
                    .tint(.blue)
                }
            }
            .listRowSeparator(Visibility.hidden)
        }
    }

    private func bagCard(for bag: Bag, swipeActions: some View) -> some View {
        BagCard(oneBag: bag)
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                swipeActions
            }
    }


    // MARK: - Functions
    private func unfixBag(bag: Bag) {
        if let index = bagViewModel.bagListFix.firstIndex(of: bag) {
            bagViewModel.bagListFix.remove(at: index)
        }
        bagViewModel.bagListAll.append(bag)
    }

    private func moveBagToFix(bag: Bag) {
        if let index = bagViewModel.bagListAll.firstIndex(of: bag) {
            bagViewModel.bagListAll.remove(at: index)
        }
        bagViewModel.bagListFix.append(bag)
    }

    private func showDeleteAlert(bag: Bag) {
        bagToDelete = bag
        isShowingDeleteAlert = true
    }

    private func bindingFor(_ bag: Bag) -> Binding<Bag> {
        if let index = bagViewModel.bagListFix.firstIndex(of: bag) {
            return $bagViewModel.bagListFix[index]
        } else if let index = bagViewModel.bagListAll.firstIndex(of: bag) {
            return $bagViewModel.bagListAll[index]
        } else {
            return .constant(Bag(listOfItens: [], name: "Default", color: .gray, dateOfPurchase: Date()))
        }
    }

    private func deleteBag() {
        if let bagToDelete = bagToDelete {
            if let index = bagViewModel.bagListFix.firstIndex(of: bagToDelete) {
                bagViewModel.bagListFix.remove(at: index)
            } else if let index = bagViewModel.bagListAll.firstIndex(of: bagToDelete) {
                bagViewModel.bagListAll.remove(at: index)
            }
        }
        bagToDelete = nil
        isShowingDeleteAlert = false
    }

}
#Preview {
    BagListView()
}
