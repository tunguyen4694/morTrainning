//
//  MeetUpTBVC.swift
//  TrainningCourse
//
//  Created by MorHN on 05/07/2022.
//

import UIKit

class MeetUpTBVC: UITableViewCell {

    var imgMeetUp = UIImageView()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        layoutCell()
    }

    func layoutCell() {
        imgMeetUp.frame = .init(x: 0, y: 0, width: self.frame.width, height: 150)
        imgMeetUp.clipsToBounds = true
        imgMeetUp.layer.cornerRadius = 10
        imgMeetUp.contentMode = .scaleAspectFit
        self.addSubview(imgMeetUp)
    }
}
