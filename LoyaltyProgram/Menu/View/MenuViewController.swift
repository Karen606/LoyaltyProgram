//
//  MenuViewController.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//

import UIKit
import Combine

class MenuViewController: UIViewController {

    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet var menuButtons: [UIButton]!
    @IBOutlet weak var pointsTitleLabel: UILabel!
    @IBOutlet weak var pointsTextField: PaddingTextField!
    @IBOutlet weak var saveButton: UIButton!
    private let viewModel = MenuViewModel.shared
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribe()
        viewModel.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
    }
    
    func setupUI() {
        setnavigationSettingsButton()
        balanceTitleLabel.font = .regular(size: 22)
        totalBalanceLabel.font = .medium(size: 34)
        for button in menuButtons {
            button.titleLabel?.font = .medium(size: 20)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.border.cgColor
        }
        pointsTitleLabel.font = .regular(size: 15)
        saveButton.titleLabel?.font = .medium(size: 19)
        pointsTextField.layer.borderWidth = 1
        pointsTextField.layer.borderColor = UIColor.orangeBorder.cgColor
        pointsTextField.layer.cornerRadius = 3
        pointsTextField.font = .regular(size: 13)
        pointsTextField.attributedPlaceholder = NSAttributedString(string: "Points", attributes: [.font: UIFont.italic(size: 13) ?? .systemFont(ofSize: 13), .foregroundColor: #colorLiteral(red: 0.5058823529, green: 0.3450980392, blue: 0.3450980392, alpha: 1)])
        pointsTextField.delegate = self
    }
    
    func subscribe() {
        viewModel.$clients
            .receive(on: DispatchQueue.main)
            .sink { [weak self] clients in
                guard let self = self else { return }
                let points = clients.reduce(0) { $0 + $1.points }
                self.totalBalanceLabel.text = Double(points).formattedToString()
            }
            .store(in: &cancellables)
    }

    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func clickedSaveUp(_ sender: UIButton) {
        viewModel.appendPoints(points: Int(pointsTextField.text ?? "")) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                self.pointsTextField.text = nil
                self.viewModel.fetchData()
            }
        }
    }
    
    @IBAction func clickedClients(_ sender: UIButton) {
        self.pushViewController(ClientsViewController.self)
    }
    
    @IBAction func clickedManagingPoints(_ sender: UIButton) {
        self.pushViewController(ManagingPointsViewController.self)
    }
    
    deinit {
        viewModel.clear()
    }
}

extension MenuViewController: UITextFieldDelegate {
    
}
