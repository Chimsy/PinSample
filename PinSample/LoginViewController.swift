//
//  LoginViewController.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/02.
//  Copyright © 2023 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("\nℹ️ PinSample:  View Did Load \n✅")

    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        print("\nℹ️ PinSample:  Did Press Login \n✅")
    }
    
    
}


