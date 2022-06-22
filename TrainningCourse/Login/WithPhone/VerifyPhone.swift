//
//  VerifyPhone.swift
//  TrainningCourse
//
//  Created by Nguyễn Anh Tú on 22/06/2022.
//

import UIKit

class VerifyPhone: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var vFooter1: UIView!
    @IBOutlet weak var lblCode1: UILabel!
    @IBOutlet weak var vFooter2: UIView!
    @IBOutlet weak var lblCode2: UILabel!
    @IBOutlet weak var vFooter3: UIView!
    @IBOutlet weak var lblCode3: UILabel!
    @IBOutlet weak var vFooter4: UIView!
    @IBOutlet weak var lblCode4: UILabel!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    let arrNum = ["1", "2" , "3", "4", "5", "6", "7", "8", "9", "", "0", "<-"]
    
    var phone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Verify Phone"
        
        lblTitle.text = "Code is sent to " + phone
        
        btnVerify.clipsToBounds = true
        btnVerify.layer.cornerRadius = 10
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhoneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhoneCollectionViewCell")
    }
    
    @objc func cancel() {
        let vc = LoginWithPhone()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func verify(_ sender: Any) {
    }
    
    @IBAction func resendCode(_ sender: Any) {
    }
}

extension VerifyPhone: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrNum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneCollectionViewCell", for: indexPath) as! PhoneCollectionViewCell
        cell.lblNumber.text = arrNum[indexPath.row]
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
        if lblCode1.text == "" && arrNum[indexPath.row] != "<-" {
            lblCode1.text = arrNum[indexPath.row]
            vFooter1.isHidden = true
        } else if lblCode1.text != "" && lblCode2.text == "" && arrNum[indexPath.row] != "<-" {
            lblCode2.text = arrNum[indexPath.row]
            vFooter2.isHidden = true
        } else if lblCode2.text != "" && lblCode3.text == "" && arrNum[indexPath.row] != "<-" {
            lblCode3.text = arrNum[indexPath.row]
            vFooter3.isHidden = true
        } else if lblCode3.text != "" && lblCode4.text == "" && arrNum[indexPath.row] != "<-" {
            lblCode4.text = arrNum[indexPath.row]
            vFooter4.isHidden = true
        } else if lblCode1.text != "" && lblCode2.text != "" && lblCode3.text != "" && lblCode4.text != "" && arrNum[indexPath.row] == "<-" {
            lblCode4.text?.removeAll()
            vFooter4.isHidden = false
        } else if lblCode1.text != "" && lblCode2.text != "" && lblCode3.text != "" && lblCode4.text == "" && arrNum[indexPath.row] == "<-" {
            lblCode3.text?.removeAll()
            vFooter3.isHidden = false
        } else if lblCode1.text != "" && lblCode2.text != "" && lblCode3.text == "" && lblCode4.text == "" && arrNum[indexPath.row] == "<-" {
            lblCode2.text?.removeAll()
            vFooter2.isHidden = false
        } else if lblCode1.text != "" && lblCode2.text == "" && lblCode3.text == "" && lblCode4.text == "" && arrNum[indexPath.row] == "<-" {
            lblCode1.text?.removeAll()
            vFooter1.isHidden = false
        }
    }
}
