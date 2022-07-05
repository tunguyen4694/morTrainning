//
//  Login.swift
//  TrainningCourse
//
//  Created by admin on 16/06/2022.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var securePasswordButton: UIButton!
    @IBOutlet weak var securePassImage: UIImageView!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var loginFBButton: FBLoginButton!
    
    let signInConfig = GIDConfiguration(clientID: "413837536092-qi02fsirc5gl6gnhr5t9700bgnc1quee.apps.googleusercontent.com")
    
    var previousScrollOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        
        formView.layer.cornerRadius = 10
        
        emailView.clipsToBounds = true
        emailView.layer.borderWidth = 0.5
        emailView.layer.borderColor = UIColor.borderColor().cgColor
        emailView.layer.cornerRadius = 10
        
        passwordView.clipsToBounds = true
        passwordView.layer.borderWidth = 0.5
        passwordView.layer.borderColor = UIColor.borderColor().cgColor
        passwordView.layer.cornerRadius = 10
        
        loginView.layer.cornerRadius = 10
        loginView.backgroundColor = .mainColor()
        
        passwordTextField.isSecureTextEntry = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func loginWithSMS(_ sender: Any) {
        let vc = LoginWithPhone()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            if let error = error {
                // ...
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    let authError = error as NSError
                    if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                        // The user is a multi-factor user. Second factor challenge is required.
                        let resolver = authError
                            .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                        var displayNameString = ""
                        for tmpFactorInfo in resolver.hints {
                            displayNameString += tmpFactorInfo.displayName ?? ""
                            displayNameString += " "
                        }
                        
                    } else {
                        
                        return
                    }
                    // ...
                    return
                }
                // User is signed in
                // ...
            }
        }
    }
    
    @IBAction func signInFb(_ sender: Any) {
        let loginManager = LoginManager()
        //        loginManager.logOut()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self, completion: { (LoginResult) in
            switch LoginResult {
            case .failed(let error):
                print("errorrrr", error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                let credential = FacebookAuthProvider
                    .credential(withAccessToken: AccessToken.current!.tokenString)
                print("Logged in! \(grantedPermissions) - \(declinedPermissions) - \(accessToken)")
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        let authError = error as NSError
                        if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                            // The user is a multi-factor user. Second factor challenge is required.
                            let resolver = authError
                                .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                            var displayNameString = ""
                            for tmpFactorInfo in resolver.hints {
                                displayNameString += tmpFactorInfo.displayName ?? ""
                                displayNameString += " "
                            }
                        } else {
                            return
                        }
                        // ...
                        return
                    }
                    // User is signed in
                    // ...
                }
                
            }
        })
    }
    
    @IBAction func login(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let _ = self else { return }
            if let _ = authResult {
                let sb = UIStoryboard(name: "HomeVC", bundle: nil)
                if let vc = sb.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: "\(error?.localizedDescription ?? "")", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel)
                alertController.addAction(ok)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func securePassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        passwordTextField.isSecureTextEntry ? (securePassImage.image = UIImage(systemName: "eye")) : (securePassImage.image = UIImage(systemName: "eye.slash"))
    }
    
    @IBAction func onNextSignup(_ sender: Any) {
        let sb = UIStoryboard(name: "SignUpVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? SignUpViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

