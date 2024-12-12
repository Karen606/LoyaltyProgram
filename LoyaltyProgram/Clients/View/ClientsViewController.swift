//
//  ClientsViewController.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//

import UIKit
import Combine

class ClientsViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var clientsTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    private let viewModel = ClientsViewModel.shared
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribe()
        viewModel.fetchData()
    }
    
    func setupUI() {
        setNavigationMenuButton()
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter the name of the client", attributes: [.font: UIFont.bold(size: 9) ?? .systemFont(ofSize: 10), .foregroundColor: #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)])
        searchTextField.font = .bold(size: 9)
        saveButton.titleLabel?.font = .black(size: 9)
        addButton.titleLabel?.font = .semibold(size: 16)
        clientsTableView.register(UINib(nibName: "ClientTableViewCell", bundle: nil), forCellReuseIdentifier: "ClientTableViewCell")
        clientsTableView.delegate = self
        clientsTableView.dataSource = self
        searchTextField.delegate = self
    }
    
    func subscribe() {
        viewModel.$clients
            .receive(on: DispatchQueue.main)
            .sink { [weak self] clients in
                guard let self = self else { return }
                self.clientsTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @IBAction func clickedSearch(_ sender: UIButton) {
        viewModel.filter(by: searchTextField.text)
    }
    
    @IBAction func clickedAdd(_ sender: UIButton) {
        let clientFormVC = ClientFormViewController(nibName: "ClientFormViewController", bundle: nil)
        clientFormVC.completion = { [weak self] in
            guard let self = self else { return }
            self.viewModel.fetchData()
        }
        self.navigationController?.pushViewController(clientFormVC, animated: true)
    }
    
    deinit {
        viewModel.clear()
    }
}

extension ClientsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.clients.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientTableViewCell", for: indexPath) as! ClientTableViewCell
        cell.configure(client: viewModel.clients[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }
}

extension ClientsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
