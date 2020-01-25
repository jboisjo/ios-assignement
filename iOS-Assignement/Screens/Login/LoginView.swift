//
//  LoginView.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewDelegate: class {
    func actionElement()
}

class LoginView: NibView {
    weak var delegate: LoginViewDelegate?
    
    @IBOutlet weak var getlist: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func getlist(_ sender: UIButton) {
        delegate?.actionElement()
    }
    
}
