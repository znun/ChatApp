//
//  ViewController.swift
//  ChatApp
//
//  Created by Xunnun on 6/3/22.
//

import UIKit
import ProgressHUD
import Gallery

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
        setupBackgroundTap()
    }

    //MARK: - IBActions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if isDataInputdFor(type: isLogin ? "login" : "register")
        {
            //Login or Register
            isLogin ? loginUser() : registerUser()
        } else {
            ProgressHUD.showFailed("All field are required")
        }
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        if isDataInputdFor(type: "password")
        {
            resetPassword()
        } else {
            ProgressHUD.showFailed("Email is required")
        }
    }
    
    @IBAction func resendEmailButtonPressed(_ sender: Any) {
        if isDataInputdFor(type: "password") {
            resendVerificationEmail()
        } else {
            ProgressHUD.showFailed("Email is required")
        }
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
    
    private func setupBackgroundTap()
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTap()
    {
        view.endEditing(false)
    }
    
    //Mark: - Animation
    
    private func updateUIFor(login: Bool)
    {
        loginButton.setImage(UIImage(named: login ? "loginBtn" : "registerBtn"), for: .normal)
        signUpButton.setTitle(login ? "SignUp" : "Login", for: .normal)
        signUpLbl.text = login ? "Don't have an account?" : "Have an account?"
        
        UIView.animate(withDuration: 0.10)
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
    
    //MARK: - Helpers
    private func isDataInputdFor(type: String) -> Bool
    {
        switch type
        {
        case "login":
            return emailTextField.text != "" && passwordTextField.text != ""
        case "registration":
            return emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != ""
        default:
            return emailTextField.text != ""
        }
    }
    
    private func loginUser() {
        //print("Yahooooooo")
        FirebaseUserListener.shared.loginUserWithEmail(email: emailTextField.text!, password: passwordTextField.text!) { (error, isEmailVerified) in
            if error == nil {
                if isEmailVerified {
                    
                    self.gotoApp()
                } else {
                    ProgressHUD.showFailed("Please verify Email")
                    self.resendEmailButton.isHidden = false
                }
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
    }
    private func registerUser() {
        if passwordTextField.text == repeatPasswordTextField.text {
            FirebaseUserListener.shared.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
                
                if error == nil {
                    ProgressHUD.showSucceed("Verificition email sent")
                    self.resendEmailButton.isHidden = false
                } else {
                    ProgressHUD.showFailed(error?.localizedDescription)
                }
            }
        } else {
            ProgressHUD.showError("The Password don't match")
        }
    }
    
    private func resetPassword() {
        FirebaseUserListener.shared.resetPasswordFor(email: emailTextField.text!) { (error) in
            if error == nil {
                ProgressHUD.showSuccess("Reset link send to Email")
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
    }
    private func resendVerificationEmail() {
        FirebaseUserListener.shared.resendVerificationEmail(email: emailTextField.text!) { (error) in
            if error == nil {
                ProgressHUD.showSuccess("New verification Email sent")
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
    }
    //MARK: - Navigation
    private func gotoApp() {
        
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as! UITabBarController
        
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)

    }
    
   
}

