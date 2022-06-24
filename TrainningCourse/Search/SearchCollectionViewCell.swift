//
//  SearchCollectionViewCell.swift
//  TrainningCourse
//
//  Created by MorHN on 24/06/2022.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vCell: UIView!
    @IBOutlet weak var lblSearch: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        vCell.layer.cornerRadius = 10
    }

}
