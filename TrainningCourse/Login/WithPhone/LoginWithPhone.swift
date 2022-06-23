//
//  LoginWithPhone.swift
//  TrainningCourse
//
//  Created by Nguyễn Anh Tú on 21/06/2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class LoginWithPhone: UIViewController, AuthUIDelegate {

    @IBOutlet weak var vPhoneNumber: UIView!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var btnPhoneNumber: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let arrNum = ["1", "2" , "3", "4", "5", "6", "7", "8", "9", "", "0", "<-"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        vPhoneNumber.clipsToBounds = true
        vPhoneNumber.layer.borderWidth = 1
        vPhoneNumber.layer.borderColor = UIColor(red: 0.722, green: 0.722, blue: 0.824, alpha: 1).cgColor
        vPhoneNumber.layer.cornerRadius = 10
        
        btnPhoneNumber.clipsToBounds = true
        btnPhoneNumber.layer.cornerRadius = 10
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhoneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhoneCollectionViewCell")
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Continue with Phone"
//        collectionView.backgroundColor = .red
    }
    
    @IBAction func verifyPhoneNumber(_ sender: Any) {
        let vc = VerifyPhone()
        vc.phone = tfPhoneNumber.text ?? ""
        navigationController?.pushViewController(vc, animated: true)
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+84\(tfPhoneNumber.text ?? "")", uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("Success")
                }
                Auth.auth().languageCode = "vn"
                
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            if let verificationID = verificationID {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: "111111")
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
    }
}

extension LoginWithPhone: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrNum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneCollectionViewCell", for: indexPath) as! PhoneCollectionViewCell
        cell.lblNumber.text = arrNum[indexPath.row]
        cell.delegate = self
        if indexPath.row == 11 {
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(clickLongPress(_:)))
            cell.vNumber.addGestureRecognizer(longPressRecognizer)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width/3, height: collectionView.bounds.height/6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if arrNum[indexPath.row] == "<-" && tfPhoneNumber.text != "" {
            tfPhoneNumber.text?.removeLast()
        } else if arrNum[indexPath.row] != "<-" {
            tfPhoneNumber.text? += arrNum[indexPath.row]
        }
    }
}

extension LoginWithPhone: PhoneCollectionViewCellDelegate {
    @objc func clickLongPress(_ sender: UILongPressGestureRecognizer) {
        print("LongPress")
        
//        var timer: Timer?
//
//        switch sender.state {
//        case .began:
//                timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { _ in
//                    self.tfPhoneNumber.text?.removeLast()
//                })
//        case . cancelled, . ended:
//            timer?.invalidate()
//            timer = nil
//        default:
//            break
//        }
        
        tfPhoneNumber.text?.removeAll()
    }
}
