//
//  FilterVC.swift
//  TrainningCourse
//
//  Created by MorHN on 06/07/2022.
//

import Foundation
import UIKit
import MultiSlider

class FilterVC: UIViewController {
    
    @IBOutlet weak var vFilter: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    let multiSlider = MultiSlider()
    
    @IBOutlet weak var collectionViewCaterogies: UICollectionView!
    @IBOutlet weak var collectionViewDuration: UICollectionView!
    
    let arrCaterogies = ["Design", "Painting", "Coding", "Music", "Visual identiy", "Mathmatics"]
    let arrDuration = ["3-8 Hours", "8-14 Hours", "14-20 Hours", "20-24 Hours", "24-30 Hours"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        vFilter.layer.cornerRadius = 20
        vFilter.backgroundColor = .white
        vFilter.addSubview(multiSlider)
        vFilter.translatesAutoresizingMaskIntoConstraints = false
        multiSlider.translatesAutoresizingMaskIntoConstraints = false
        multiSlider.topAnchor.constraint(equalTo: lblPrice.bottomAnchor, constant: 10).isActive = true
        multiSlider.leadingAnchor.constraint(equalTo: lblPrice.leadingAnchor, constant: 0).isActive = true
        multiSlider.trailingAnchor.constraint(equalTo: lblPrice.trailingAnchor, constant: 0).isActive = true
        multiSlider.maximumValue = 400
        multiSlider.value = [90, 200]
        multiSlider.orientation = .horizontal
        multiSlider.tintColor = .mainColor()
        multiSlider.outerTrackColor = .lightGray
        multiSlider.valueLabelPosition = .bottom
        multiSlider.valueLabelFormatter.positiveSuffix = "$"
        multiSlider.valueLabelColor = .titleColor()
        multiSlider.thumbImage = UIImage(systemName: "circle.fill")
        multiSlider.thumbTintColor = .mainColor()
        
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(
            horizontalAlignment: .left
        )
        alignedFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        collectionViewCaterogies.delegate = self
        collectionViewCaterogies.dataSource = self
        collectionViewCaterogies.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        collectionViewCaterogies.collectionViewLayout = alignedFlowLayout
        
        collectionViewDuration.delegate = self
        collectionViewDuration.dataSource = self
        collectionViewDuration.register(UINib(nibName: "DurationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DurationCollectionViewCell")
        collectionViewDuration.collectionViewLayout = alignedFlowLayout
    }
    
    @IBAction func onCancelFilter(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension FilterVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewCaterogies {
            return arrCaterogies.count
        } else {
            return arrDuration.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewCaterogies {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.lblCategory.text = arrCaterogies[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DurationCollectionViewCell", for: indexPath) as! DurationCollectionViewCell
            cell.lblDuration.text = arrDuration[indexPath.row]
            return cell
        }
    }
}
