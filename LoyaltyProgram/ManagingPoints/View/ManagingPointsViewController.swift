//
//  ManagingPointsViewController.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//

import UIKit
import Combine

class ManagingPointsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var saveUpButton: UIButton!
    @IBOutlet weak var writeOffButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var saveUpTextField: PaddingTextField!
    @IBOutlet weak var writeOffTextField: PaddingTextField!
    private let viewModel = ManagingPointsViewModel.shared
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribe()
        viewModel.fetchData()
    }
    
    func setupUI() {
        setNavigationMenuButton()
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter the phone number", attributes: [.font: UIFont.bold(size: 9) ?? .systemFont(ofSize: 10), .foregroundColor: #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)])
        searchTextField.font = .bold(size: 9)
        searchButton.titleLabel?.font = .black(size: 9)
        nameLabel.font = .regular(size: 18)
        pointsLabel.font = .regular(size: 18)
        phoneNumberLabel.font = .regular(size: 18)
        saveUpButton.titleLabel?.font = .medium(size: 18)
        writeOffButton.titleLabel?.font = .medium(size: 18)
        saveUpTextField.attributedPlaceholder = NSAttributedString(string: "Enter the points", attributes: [.font: UIFont.italic(size: 13) ?? .systemFont(ofSize: 13), .foregroundColor: #colorLiteral(red: 0.5058823529, green: 0.3450980392, blue: 0.3450980392, alpha: 1)])
        writeOffTextField.attributedPlaceholder = NSAttributedString(string: "Enter the points", attributes: [.font: UIFont.italic(size: 13) ?? .systemFont(ofSize: 13), .foregroundColor: #colorLiteral(red: 0.5058823529, green: 0.3450980392, blue: 0.3450980392, alpha: 1)])
        applyButton.titleLabel?.font = .semibold(size: 16)
        saveUpTextField.layer.borderWidth = 1
        saveUpTextField.layer.borderColor = UIColor.orangeBorder.cgColor
        saveUpTextField.layer.cornerRadius = 3
        saveUpTextField.font = .regular(size: 13)
        writeOffTextField.layer.borderWidth = 1
        writeOffTextField.layer.borderColor = UIColor.orangeBorder.cgColor
        writeOffTextField.layer.cornerRadius = 3
        writeOffTextField.font = .regular(size: 13)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.orangeBorder.cgColor
    }
    
    func subscribe() {
        viewModel.$client
            .receive(on: DispatchQueue.main)
            .sink { [weak self] client in
                guard let self = self else { return }
                contentView.isHidden = client == nil
                guard let client = client else { return }
                nameLabel.text = client.name
                phoneNumberLabel.text = client.phoneNumber
                pointsLabel.text = "Points: \(client.points)"
            }
            .store(in: &cancellables)
    }
    
    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func clickedApply(_ sender: UIButton) {
        viewModel.apply(incrementPoints: Int(saveUpTextField.text ?? ""), decrementPoints: Int(writeOffTextField.text ?? "")) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                self.saveUpTextField.text = nil
                self.writeOffTextField.text = nil
                self.viewModel.fetchData()
            }
        }
    }
    
    @IBAction func clickedSearch(_ sender: UIButton) {
        viewModel.search(by: searchTextField.text)
    }
    
    deinit {
        viewModel.clear()
    }
}
