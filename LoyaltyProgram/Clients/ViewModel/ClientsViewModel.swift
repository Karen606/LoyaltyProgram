//
//  ClientsViewModel.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//

import Foundation

class ClientsViewModel {
    static let shared = ClientsViewModel()
    private var data: [ClientModel] = []
    @Published var clients: [ClientModel] = []
    private var search: String?
    private init() {}
    
    func fetchData() {
        CoreDataManager.shared.fetchClients { [weak self] clients, _ in
            guard let self = self else { return }
            self.data = clients
            self.filter(by: search)
        }
    }
    
    func filter(by value: String?) {
        self.search = value
        if let trimmedSearch = search?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), !trimmedSearch.isEmpty {
            clients = data.filter({ $0.name?.lowercased().contains(trimmedSearch) ?? false })
        } else {
            clients = data
        }
    }
    
    func clear() {
        data = []
        clients = []
        search = nil
    }
}
