//
//  Home.swift
//  TrainningCourse
//
//  Created by MorHN on 23/06/2022.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var v1Search: UIView!
    @IBOutlet weak var v2Search: UIView!
    
    @IBOutlet weak var vLineHome: UIView!
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var lblHome: UILabel!
    
    @IBOutlet weak var vLineCourse: UIView!
    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblCourse: UILabel!
    
    @IBOutlet weak var vLineMessage: UIView!
    @IBOutlet weak var imgMessage: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var vLineAcc: UIView!
    @IBOutlet weak var imgAcc: UIImageView!
    @IBOutlet weak var lblAcc: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!

    var arrImage = ["ads", "ads1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    

    func configUI() {
        view.backgroundColor = .mainColor()
        vTop.layer.cornerRadius = 10
        v1Search.layer.cornerRadius = 30
        v2Search.layer.cornerRadius = 25
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdsCollectionViewCell")
    }
    
    @IBAction func onHome(_ sender: Any) {
        vLineHome.backgroundColor = .mainColor()
        vLineHome.isHidden = false
        vLineCourse.backgroundColor = .iconColor()
        vLineCourse.isHidden = true
        vLineMessage.backgroundColor = .iconColor()
        vLineMessage.isHidden = true
        vLineAcc.backgroundColor = .iconColor()
        vLineAcc.isHidden = true
        imgHome.tintColor = .mainColor()
        imgCourse.tintColor = .iconColor()
        imgMessage.tintColor = .iconColor()
        imgAcc.tintColor = .iconColor()
        lblHome.textColor = .mainColor()
        lblCourse.textColor = .iconColor()
        lblMessage.textColor = .iconColor()
        lblAcc.textColor = .iconColor()
    }
    @IBAction func onCourse(_ sender: Any) {
        vLineHome.backgroundColor = .iconColor()
        vLineHome.isHidden = true
        vLineCourse.backgroundColor = .mainColor()
        vLineCourse.isHidden = false
        vLineMessage.backgroundColor = .iconColor()
        vLineMessage.isHidden = true
        vLineAcc.backgroundColor = .iconColor()
        vLineAcc.isHidden = true
        imgHome.tintColor = .iconColor()
        imgCourse.tintColor = .mainColor()
        imgMessage.tintColor = .iconColor()
        imgAcc.tintColor = .iconColor()
        lblHome.textColor = .iconColor()
        lblCourse.textColor = .mainColor()
        lblMessage.textColor = .iconColor()
        lblAcc.textColor = .iconColor()
    }
    
    @IBAction func onSearch(_ sender: Any) {
    }
    @IBAction func onMessage(_ sender: Any) {
        vLineHome.backgroundColor = .iconColor()
        vLineHome.isHidden = true
        vLineCourse.backgroundColor = .iconColor()
        vLineCourse.isHidden = true
        vLineMessage.backgroundColor = .mainColor()
        vLineMessage.isHidden = false
        vLineAcc.backgroundColor = .iconColor()
        vLineAcc.isHidden = true
        imgHome.tintColor = .iconColor()
        imgCourse.tintColor = .iconColor()
        imgMessage.tintColor = .mainColor()
        imgAcc.tintColor = .iconColor()
        lblHome.textColor = .iconColor()
        lblCourse.textColor = .iconColor()
        lblMessage.textColor = .mainColor()
        lblAcc.textColor = .iconColor()
    }
    @IBAction func onAccount(_ sender: Any) {
        vLineHome.backgroundColor = .iconColor()
        vLineHome.isHidden = true
        vLineCourse.backgroundColor = .iconColor()
        vLineCourse.isHidden = true
        vLineMessage.backgroundColor = .iconColor()
        vLineMessage.isHidden = true
        vLineAcc.backgroundColor = .mainColor()
        vLineAcc.isHidden = false
        imgHome.tintColor = .iconColor()
        imgCourse.tintColor = .iconColor()
        imgMessage.tintColor = .iconColor()
        imgAcc.tintColor = .mainColor()
        lblHome.textColor = .iconColor()
        lblCourse.textColor = .iconColor()
        lblMessage.textColor = .iconColor()
        lblAcc.textColor = .mainColor()
        
        let sb = UIStoryboard(name: "Account", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? AccountViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCollectionViewCell", for: indexPath) as! AdsCollectionViewCell
        cell.imgAds.image = UIImage(named: arrImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width/1.5, height: collectionView.bounds.height)
    }
}
