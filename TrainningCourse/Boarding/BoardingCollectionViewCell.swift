//
//  BoardingCollectionViewCell.swift
//  TrainningCourse
//
//  Created by admin on 16/06/2022.
//

import UIKit

class BoardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.numberOfLines = 0
        contentLabel.numberOfLines = 0
        
    }

}
