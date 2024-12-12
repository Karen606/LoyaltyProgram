//
//  CoreDataManager.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//


import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LoyaltyProgram")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveClient(clientModel: ClientModel, completion: @escaping (Error?) -> Void) {
        let id = clientModel.id
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            let fetchRequest: NSFetchRequest<Client> = Client.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            do {
                let results = try backgroundContext.fetch(fetchRequest)
                let client: Client
                
                if let existingClient = results.first {
                    client = existingClient
                } else {
                    client = Client(context: backgroundContext)
                    client.id = id
                }
                
                client.name = clientModel.name
                client.points = Int64(clientModel.points)
                client.phoneNumber = clientModel.phoneNumber
                
                try backgroundContext.save()
                DispatchQueue.main.async {
                    completion(nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }
    
    func fetchClients(completion: @escaping ([ClientModel], Error?) -> Void) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            let fetchRequest: NSFetchRequest<Client> = Client.fetchRequest()
            do {
                let results = try backgroundContext.fetch(fetchRequest)
                var clientsModel: [ClientModel] = []
                for result in results {
                    let clientModel = ClientModel(id: result.id ?? UUID(), name: result.name, points: Int(result.points), phoneNumber: result.phoneNumber)
                    clientsModel.append(clientModel)
                }
                DispatchQueue.main.async {
                    completion(clientsModel, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([], error)
                }
            }
        }
    }
    
//    func changeOrderStatus(orderId: UUID, newStatus: Int, completion: @escaping (Error?) -> Void) {
//        let backgroundContext = persistentContainer.newBackgroundContext()
//        backgroundContext.perform {
//            let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "id == %@", orderId as CVarArg)
//            
//            do {
//                if let order = try backgroundContext.fetch(fetchRequest).first {
//                    order.status = Int32(newStatus)
//                    try backgroundContext.save()
//                    DispatchQueue.main.async {
//                        completion(nil)
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Order not found"]))
//                    }
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion(error)
//                }
//            }
//        }
//    }
}