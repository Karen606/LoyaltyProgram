//
//  MenuViewModel.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//

import Foundation

class MenuViewModel {
    static let shared = MenuViewModel()
    @Published var clients: [ClientModel] = []
    private init() {}
    
    func fetchData() {
        CoreDataManager.shared.fetchClients { [weak self] clients, _ in
            guard let self = self else { return }
            self.clients = clients
        }
    }
    
    func appendPoints(points: Int?, completion: @escaping (Error?) -> Void) {
        if let points = points {
            CoreDataManager.shared.addPointsToAllClients(points: points, completion: completion)
        }
    }
    
    func clear() {
        clients = []
    }
}
