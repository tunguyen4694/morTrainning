//
//  MyCourse.swift
//  TrainningCourse
//
//  Created by MorHN on 27/06/2022.
//

import Foundation
import UIKit

class MyCourseViewController: UIViewController {
    
    var arrCourse = ["Product Design v1.0", "Java Development", "Visual Design"]
    var arrBackgroundColor = [UIColor(red: 1.00, green: 0.91, blue: 0.93, alpha: 1.00), UIColor(red: 0.73, green: 0.84, blue: 1.00, alpha: 1.00), UIColor(red: 0.73, green: 0.88, blue: 0.86, alpha: 1.00)]
    var arrBtnColor = [UIColor(red: 0.93, green: 0.48, blue: 0.61, alpha: 1.00), UIColor(red: 0.24, green: 0.36, blue: 1.00, alpha: 1.00), UIColor(red: 0.22, green: 0.54, blue: 0.50, alpha: 1.00)]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "My Course"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MyCourseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCourseCollectionViewCell")
    }
}

extension MyCourseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrBackgroundColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCourseCollectionViewCell", for: indexPath) as! MyCourseCollectionViewCell
        cell.lblName.text = arrCourse[indexPath.row]
        cell.vContainer.backgroundColor = arrBackgroundColor[indexPath.row]
        cell.btnPlay.tintColor = arrBtnColor[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
