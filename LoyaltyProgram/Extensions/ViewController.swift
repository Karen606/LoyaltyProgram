//
//  ViewController.swift
//  Party
//
//  Created by Karen Khachatryan on 15.10.24.
//

import UIKit

extension UIViewController {
    
    func setNavigationTitle(title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = .medium(size: 20)
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    func setNavigationBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(.backIcon, for: .normal)
        backButton.addTarget(self, action: #selector(clickedBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func setNavigationMenuButton() {
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(.homeIcon, for: .normal)
        menuButton.addTarget(self, action: #selector(clickedMenu), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
    
    func setnavigationSettingsButton() {
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(.settingsIcon, for: .normal)
        menuButton.addTarget(self, action: #selector(clickedSettings), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
    
    @objc func clickedBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }
    
    @objc func clickedMenu() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func clickedSettings() {
        self.pushViewController(SettingsViewController.self)
    }
    
    func pushViewController<T: UIViewController>(_ viewControllerType: T.Type, animated: Bool = true) {
        let nibName = String(describing: viewControllerType)
        let viewController = T(nibName: nibName, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view // Your source view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alertController, animated: true, completion: nil)
    }
}

