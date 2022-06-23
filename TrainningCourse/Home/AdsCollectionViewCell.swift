//
//  AdsCollectionViewCell.swift
//  TrainningCourse
//
//  Created by MorHN on 23/06/2022.
//

import UIKit

class AdsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var imgAds: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vContainer.clipsToBounds = true
        vContainer.layer.cornerRadius = 10
        imgAds.contentMode = .scaleAspectFill
    }

}
