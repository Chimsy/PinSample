//
//  LoginViewController.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/02.
//  Copyright © 2023 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK:Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("\nℹ️ PinSample:  View Did Load \n✅")

    }
    
    
    // MARK: Helper Methods
    private func loggingIn(_ isLogginIn: Bool) {
        if isLogginIn {
            loginActivityIndicator.startAnimating()
        } else {
            loginActivityIndicator.stopAnimating()
        }
        
        //disable interactable views when login in progress
        emailTextField.isEnabled = !isLogginIn
        passwordTextField.isEnabled = !isLogginIn
        loginButton.isEnabled = !isLogginIn
        signUpButton.isEnabled = !isLogginIn
    }
    
    private func fetchStudentLocations() {
        OnTheMapClient.getStudentLocations { (success, error) in
            self.loggingIn(false)
            if success {
                self.performSegue(withIdentifier: "showLocations", sender: nil)
            } else {
                self.showErrorAlert(message: error?.localizedDescription ?? "Login Failed")
            }
        }
    }
    
    // MARK: Button Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        print("\nℹ️ PinSample:  Did Press Login \n✅")
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        print("\nℹ️ PinSample:  Did Press SignUp \n✅")
    }
    
}


