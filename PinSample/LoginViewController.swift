//
//  LoginViewController.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/02.
//  Copyright © 2023 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    private let autoHideKeyboardDelegate = HideKeyboardOnEnterDelegate()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = autoHideKeyboardDelegate
        passwordTextField.delegate = autoHideKeyboardDelegate
    }
    
    
    // MARK: Helper Methods
    private func loggingIn(_ isLogginIn: Bool) {
        
        isLogginIn ? loginActivityIndicator.startAnimating() : loginActivityIndicator.stopAnimating()
        
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
    
    func confirmCaptureOfPersonalInformation(success: Bool, error: Error?) {
        if !success{
            self.showErrorAlert(message: error?.localizedDescription ?? "Failed to fetch User Information")
        }
    }
    
    // MARK: Button Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        loggingIn(true)
        
        OnTheMapClient.login(email: emailTextField.text!, password: passwordTextField.text!) { success, error in
            if success {
                OnTheMapClient.getUserInformationRequest(completion: self.confirmCaptureOfPersonalInformation(success:error:))
                self.fetchStudentLocations()
            } else {
                self.loggingIn(false)
                self.showErrorAlert(message: error?.localizedDescription ?? "Login Failed")
            }
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        openUrl(url: OnTheMapClient.Endpoints.signUp.url)
    }
    
}


