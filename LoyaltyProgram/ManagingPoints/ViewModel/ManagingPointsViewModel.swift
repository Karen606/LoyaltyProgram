//
//  ManagingPointsViewModel.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//

import Foundation

class ManagingPointsViewModel {
    static let shared = ManagingPointsViewModel()
    private var clients: [ClientModel] = []
    @Published var client: ClientModel?
    private var search: String?
    private init() {}
    
    func fetchData() {
        CoreDataManager.shared.fetchClients { [weak self] clients, _ in
            guard let self = self else { return }
            self.clients = clients
            self.search(by: search)
        }
    }
    
    func apply(incrementPoints: Int?, decrementPoints: Int?, completion: @escaping (Error?) -> Void) {
        guard let client = client else { return }
        CoreDataManager.shared.changePoints(clientID: client.id, incrementPoints: incrementPoints, decrementPoints: decrementPoints, completion: completion)
    }
    
    func search(by value: String?) {
        search = value
        client = clients.first(where: { $0.phoneNumber == value })
    }
    
    func clear() {
        clients = []
        client = nil
        search = nil
    }
}
