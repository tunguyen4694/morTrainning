//
//  CategoriesCollectionViewCell.swift
//  TrainningCourse
//
//  Created by MorHN on 06/07/2022.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vContainer.layer.cornerRadius = 10
    }
    
    override var isSelected: Bool {
        didSet {
            self.vContainer.backgroundColor = isSelected ? .mainColor() : .iconColor()
            self.lblCategory.textColor = isSelected ? .white : .contentColor()
        }
    }
}
