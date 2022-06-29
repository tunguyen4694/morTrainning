//
//  ModelCourse.swift
//  TrainningCourse
//
//  Created by MorHN on 24/06/2022.
//

import Foundation
import UIKit

struct Course {
    var image: UIImage!
    var name: String
    var trainer: String
    var prix: String
    var time: String
    
    init(image: UIImage? = nil, name: String, trainer: String, prix: String, time: String) {
        self.image = image
        self.name = name
        self.trainer = trainer
        self.prix = prix
        self.time = time
    }
}

func courseData() -> [Course] {
    var courses: [Course] = []
    
    let course1 = Course(image: UIImage(named: "course1"), name: "Product Degin v1.0", trainer: "Robertson Connie", prix: "$190", time: "16 hours")
    
    let course2 = Course(image: UIImage(named: "course2"), name: "Java Development", trainer: "Nguyen Shane", prix: "$190", time: "16 hours")
    
    let course3 = Course(image: UIImage(named: "course3"), name: "Visual Design", trainer: "Bert Pullman", prix: "$250", time: "14 hours")
    
    let course4 = Course(image: UIImage(named: "course1"), name: "Product Degin v1.0", trainer: "Robertson Connie", prix: "$190", time: "16 hours")
    
    let course5 = Course(image: UIImage(named: "course2"), name: "Java Development", trainer: "Nguyen Shane", prix: "$190", time: "16 hours")
    
    let course6 = Course(image: UIImage(named: "course3"), name: "Visual Design", trainer: "Bert Pullman", prix: "$250", time: "14 hours")
    
    let course7 = Course(image: UIImage(named: "course1"), name: "Product Degin v1.0", trainer: "Robertson Connie", prix: "$190", time: "16 hours")
    
    let course8 = Course(image: UIImage(named: "course2"), name: "Java Development", trainer: "Nguyen Shane", prix: "$190", time: "16 hours")
    
    let course9 = Course(image: UIImage(named: "course3"), name: "Visual Design", trainer: "Bert Pullman", prix: "$250", time: "14 hours")
    
    courses.append(contentsOf: [course1, course2, course3, course4, course5, course6, course7, course8, course9])
    
    return courses
}
