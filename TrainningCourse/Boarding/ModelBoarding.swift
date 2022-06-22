//
//  ModelBoarding.swift
//  TrainningCourse
//
//  Created by admin on 16/06/2022.
//

import Foundation
import UIKit

struct BoardingData {
    internal init(image: UIImage? = nil, title: String, content: String) {
        self.image = image
        self.title = title
        self.content = content
    }
    
    var image: UIImage!
    var title: String
    var content: String
}

func fakeBoadingData() -> [BoardingData] {
    var boarding: [BoardingData] = []
    
    let boarding1 = BoardingData(image: UIImage.init(named: "illustration1"), title: "Numerous free trial courses", content: "Free courses for you to find your way to learning")
    let boarding2 = BoardingData(image: UIImage.init(named: "illustration2"), title: "Quick and easy learning", content: "Easy and fast learning at any time to help you improve various skills")
    let boarding3 = BoardingData(image: UIImage.init(named: "illustration3"), title: "Create your own study plan", content: "Study according to the study plan, make study more motivated")
    
    boarding.append(contentsOf: [boarding1, boarding2, boarding3])
    
    return boarding
}

