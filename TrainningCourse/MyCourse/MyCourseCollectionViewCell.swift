//
//  MyCourseCollectionViewCell.swift
//  TrainningCourse
//
//  Created by MorHN on 06/07/2022.
//

import UIKit

class MyCourseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vContainer.layer.cornerRadius = 10
        btnPlay.layer.cornerRadius = btnPlay.frame.width/2
    }

}
