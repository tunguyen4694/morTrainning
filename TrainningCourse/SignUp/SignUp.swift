//
//  SignUp.swift
//  TrainningCourse
//
//  Created by admin on 16/06/2022.
//

import Foundation
import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var creatView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var checkEmailImage: UIImageView!
    
    @IBOutlet weak var agreeImage: UIImageView!
    
    @IBOutlet weak var securePassImage: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var isCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formView.layer.cornerRadius = 10
        
        emailView.clipsToBounds = true
        emailView.layer.cornerRadius = 10
        emailView.layer.borderColor = UIColor.borderColor().cgColor
        emailView.layer.borderWidth = 0.5
        
        passwordView.clipsToBounds = true
        passwordView.layer.cornerRadius = 10
        passwordView.layer.borderColor = UIColor.borderColor().cgColor
        passwordView.layer.borderWidth = 0.5
        
        creatView.clipsToBounds = true
        creatView.layer.cornerRadius = 10
        creatView.layer.opacity = 0.5
        creatView.backgroundColor = .mainColor()
        
        passwordTextField.isSecureTextEntry = true
        
//        emailTextField.delegate = self
    }
    
    @IBAction func signUp(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        var errorMessage = ""
        var alertController = UIAlertController()
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(ok)
        
        if isCheck {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let user = authResult?.user {
                    print("Create Success")
                    print("User's information: \(user.email) - \(user.uid)")
                    let vc = Success()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    print("Not Success")
                    print("Error: \(error?.localizedDescription ?? "")")
                    errorMessage = error?.localizedDescription ?? ""
                    alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    alertController.addAction(ok)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            print("Please! Agree with our Policy")
            errorMessage = "Please! Agree with our Policy"
            alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func securePassword(_ sender: Any) {
        if securePassImage.image == UIImage(systemName: "eye") {
            securePassImage.image = UIImage(systemName: "eye.slash")
            passwordTextField.isSecureTextEntry = false
        } else {
            securePassImage.image = UIImage(systemName: "eye")
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func onAgreePolicy(_ sender: Any) {
        if !isCheck {
            agreeImage.image = UIImage(systemName: "checkmark.square.fill")
            creatView.layer.opacity = 1
            isCheck = true
        } else {
            agreeImage.image = UIImage(systemName: "square")
            creatView.layer.opacity = 0.5
            isCheck = false
        }
    }
    
    @IBAction func onNextLogin(_ sender: Any) {
        let sb = UIStoryboard(name: "LogIn", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? LoginViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//extension SignUpViewController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        let email = textField.text ?? ""
//        Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
//            if let _ = error {
//                self.checkEmailImage.image = UIImage(systemName: "checkmark.circle")
//                self.checkEmailImage.tintColor = .systemRed
//            } else {
//                self.checkEmailImage.image = UIImage(systemName: "checkmark.circle.fill")
//                self.checkEmailImage.tintColor = .systemGreen
//            }
//        }
//    }
//}
