//
//  PhoneCollectionViewCell.swift
//  TrainningCourse
//
//  Created by Nguyễn Anh Tú on 21/06/2022.
//

import UIKit

protocol PhoneCollectionViewCellDelegate {
    func clickLongPress(_ sender: UILongPressGestureRecognizer)
}

class PhoneCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vNumber: UIView!
    @IBOutlet weak var lblNumber: UILabel!
    
    var delegate: PhoneCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer) {
        delegate?.clickLongPress(sender)
    }
}
