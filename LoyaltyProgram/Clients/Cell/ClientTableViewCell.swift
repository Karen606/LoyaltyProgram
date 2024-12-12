//
//  ClientTableViewCell.swift
//  LoyaltyProgram
//
//  Created by Karen Khachatryan on 12.12.24.
//

import UIKit

class ClientTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.orangeBorder.cgColor
        nameLabel.font = .regular(size: 18)
        pointsLabel.font = .regular(size: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(client: ClientModel) {
        nameLabel.text = client.name
        pointsLabel.text = "Points: \(client.points)"
    }
}
