//
//  ClientFormViewController.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//

import UIKit
import Combine

class ClientFormViewController: UIViewController {

    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet weak var phoneNumberTextField: BaseTextField!
    @IBOutlet weak var nameTextField: BaseTextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: BaseButton!
    private let viewModel = ClientFormViewModel.shared
    private var cancellables: Set<AnyCancellable> = []
    var completion: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribe()
    }
    
    func setupUI() {
        self.navigationItem.hidesBackButton = true
        setNavigationTitle(title: "Registering a new client")
        titleLabels.forEach({ $0.font = .regular(size: 18 )})
        cancelButton.titleLabel?.font = .semibold(size: 16)
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.button.cgColor
        cancelButton.layer.cornerRadius = 3
        phoneNumberTextField.delegate = self
        nameTextField.delegate = self
    }
    
    func subscribe() {
        viewModel.$client
            .receive(on: DispatchQueue.main)
            .sink { [weak self] client in
                guard let self = self else { return }
                self.nameTextField.text = client.name
                self.phoneNumberTextField.text = client.phoneNumber
                self.saveButton.isEnabled = (client.name.checkValidation() && client.phoneNumber.checkValidation())
            }
            .store(in: &cancellables)
    }
    
    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func clickedCancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedSave(_ sender: BaseButton) {
        viewModel.save { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                self.completion?()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    deinit {
        viewModel.clear()
    }
}

extension ClientFormViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == nameTextField {
            viewModel.client.name = textField.text
        } else if textField == phoneNumberTextField {
            viewModel.client.phoneNumber = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
