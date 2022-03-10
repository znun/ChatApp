//
//  ViewController.swift
//  ChatApp
//
//  Created by Xunnun on 6/3/22.
//

import UIKit


class LoginViewController: UIViewController {
    
    //MARK:- IBOutlets

    //Labels
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var repeatPasswordLbl: UILabel!
    @IBOutlet weak var signUpLbl: UILabel!
    
    //TextFields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    //Buttons
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var resendEmailButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    //Views
    @IBOutlet weak var repeatPasswordLineView: UIView!
    
    //MARK: - Variables
    var isLogin = true
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIFor(login: true)
        setupTextFieldDelegates()
    }

    //MARK: - IBActions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
    }
    
    @IBAction func resendEmailButtonPressed(_ sender: Any) {
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        updateUIFor(login: sender.titleLabel?.text == "Login")
        isLogin.toggle()
    }
    
    //MARK: - Setup
    private func setupTextFieldDelegates()
    {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        updatePlaceholderLabels(textField: textField)
    }
    
    //Mark: - Animation
    
    private func updateUIFor(login: Bool)
    {
        loginButton.setImage(UIImage(named: login ? "loginBtn" : "registerBtn"), for: .normal)
        signUpButton.setTitle(login ? "SignUp" : "Login", for: .normal)
        signUpLbl.text = login ? "Don't have an account?" : "Have an account?"
        
        UIView.animate(withDuration: 0.5)
        {
            self.repeatPasswordLbl.isHidden = login
            self.repeatPasswordTextField.isHidden = login
            self.repeatPasswordLineView.isHidden = login
        }
    }
    
    private func updatePlaceholderLabels(textField: UITextField)
    {
        switch textField {
            
        case emailTextField:
            emailLbl.text = textField.hasText ? "Email" : ""
        case passwordTextField:
            passwordLbl.text = textField.hasText ? "Password" : ""
        default:
           repeatPasswordLbl.text = textField.hasText ? "Repeat Password" : ""
        }
    }
}

