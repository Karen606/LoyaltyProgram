//
//  ClientFormViewModel.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//

import Foundation

class ClientFormViewModel {
    static let shared = ClientFormViewModel()
    @Published var client = ClientModel(id: UUID())
    private init() {}
    
    func save(completion: @escaping (Error?) -> Void) {
        CoreDataManager.shared.saveClient(clientModel: client, completion: completion)
    }
    
    func clear() {
        client = ClientModel(id: UUID())
    }
}
