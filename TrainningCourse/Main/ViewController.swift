//
//  ViewController.swift
//  TrainningCourse
//
//  Created by admin on 16/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextPage: UIPageControl!
    
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var logInView: UIView!
    
    var datas: [BoardingData] = fakeBoadingData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congig()
    }
    
    func congig() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BoardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BoardingCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        
        nextPage.numberOfPages = datas.count
        nextPage.isUserInteractionEnabled = false
        
        signUpView.clipsToBounds = true
        signUpView.layer.cornerRadius = 10
        logInView.clipsToBounds = true
        logInView.layer.cornerRadius = 10
        logInView.layer.borderWidth = 0.5
        logInView.layer.borderColor = UIColor(red: 0.722, green: 0.722, blue: 0.824, alpha: 1).cgColor
//        collectionView.backgroundColor = .systemCyan
        print(collectionView.contentOffset.x)
    }
    
    @IBAction func onSkip(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.collectionView.contentOffset.x += self.view.frame.maxX
            if self.collectionView.contentOffset.x >= self.view.frame.maxX*2 {
                self.skipButton.isHidden = true
                self.signUpView.isHidden = false
                self.logInView.isHidden = false
            }
        }, completion: nil)
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let sb = UIStoryboard(name: "SignUp", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? SignUpViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let sb = UIStoryboard(name: "LogIn", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? LoginViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        let vc = LoginWithPhone()
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardingCollectionViewCell", for: indexPath) as! BoardingCollectionViewCell
        cell.imageView.image = datas[indexPath.row].image
        cell.titleLabel.text = datas[indexPath.row].title
        cell.contentLabel.text = datas[indexPath.row].content
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(collectionView.contentOffset.x/view.bounds.width)
        nextPage.currentPage = Int(pageIndex)
        print(pageIndex)
        print(collectionView.contentOffset.x)
    }
}

