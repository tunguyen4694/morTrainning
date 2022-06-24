//
//  CourseTableViewCell.swift
//  TrainningCourse
//
//  Created by MorHN on 24/06/2022.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTrainer: UILabel!
    @IBOutlet weak var lblPrix: UILabel!
    @IBOutlet weak var vTime: UIView!
    @IBOutlet weak var lblTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vTime.layer.cornerRadius = 5
    }

}
