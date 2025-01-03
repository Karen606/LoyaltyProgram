//
//  SettingsViewController.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 13.12.24.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController {

    @IBOutlet var settingsButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setNavigationBackButton()
        for button in settingsButtons {
            button.titleLabel?.font = .medium(size: 20)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.border.cgColor
        }
    }
    
    @IBAction func clickedContactUs(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients(["andreu.gurin.2000@icloud.com"])
            present(mailComposeVC, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(
                title: "Mail Not Available",
                message: "Please configure a Mail account in your settings.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    @IBAction func clickedPrivacyPolicy(_ sender: UIButton) {
        let privacyVC = PrivacyViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(privacyVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func clickedRateUs(_ sender: UIButton) {
        let appID = "6739856113"
        if let url = URL(string: "https://apps.apple.com/app/id\(appID)?action=write-review") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Unable to open App Store URL")
            }
        }
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
