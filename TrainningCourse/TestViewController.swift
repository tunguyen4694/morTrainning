//
//  TestViewController.swift
//  TrainningCourse
//
//  Created by Nguyễn Anh Tú on 21/06/2022.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    public func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        
    }
}

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton()
                loginButton.center = view.center
                view.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }


    

}
