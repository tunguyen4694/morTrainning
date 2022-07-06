//
//  DurationCollectionViewCell.swift
//  TrainningCourse
//
//  Created by MorHN on 06/07/2022.
//

import UIKit

class DurationCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var lblDuration: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        vContainer.layer.cornerRadius = 10
    }

    override var isSelected: Bool {
        didSet {
            self.vContainer.backgroundColor = isSelected ? .mainColor() : .iconColor()
            self.lblDuration.textColor = isSelected ? .white : .contentColor()
        }
    }
}
