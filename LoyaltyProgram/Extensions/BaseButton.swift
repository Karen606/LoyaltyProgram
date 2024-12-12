//
//  BaseButton.swift
//  Party
//
//  Created by Karen Khachatryan on 15.10.24.
//

import UIKit

class BaseButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor = isEnabled ? self.backgroundColor?.withAlphaComponent(1) : self.backgroundColor?.withAlphaComponent(0.5)
        }
    }
    
    func commonInit() {
        self.titleLabel?.font = .medium(size: 16)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .button
        self.layer.cornerRadius = 20
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}
