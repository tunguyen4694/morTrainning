//
//  Course.swift
//  TrainningCourse
//
//  Created by MorHN on 24/06/2022.
//

import Foundation
import UIKit

class CourseViewController: UIViewController {
    
    @IBOutlet weak var vSearch: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vAll: UIView!
    @IBOutlet weak var vPopular: UIView!
    @IBOutlet weak var vNew: UIView!
    @IBOutlet weak var vBarSearch1: UIView!
    @IBOutlet weak var vBarSearch2: UIView!
    
    @IBOutlet weak var vLineHome: UIView!
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var lblHome: UILabel!
    
    @IBOutlet weak var vLineCourse: UIView!
    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblCourse: UILabel!
    
    @IBOutlet weak var vLineMessage: UIView!
    @IBOutlet weak var imgMessage: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var vLineAcc: UIView!
    @IBOutlet weak var imgAcc: UIImageView!
    @IBOutlet weak var lblAcc: UILabel!
    
    var datas: [Course] = courseData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congigUI()
    }
    
    func congigUI() {
        vSearch.layer.cornerRadius = 15
        vAll.layer.cornerRadius = 10
        vPopular.layer.cornerRadius = 10
        vNew.layer.cornerRadius = 10
        vBarSearch1.layer.cornerRadius = 30
        vBarSearch2.layer.cornerRadius = 25
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CourseTableViewCell", bundle: nil), forCellReuseIdentifier: "CourseTableViewCell")
    }
    
    @IBAction func onHome(_ sender: Any) {
        vLineHome.backgroundColor = .mainColor()
        vLineHome.isHidden = false
        vLineCourse.backgroundColor = .iconColor()
        vLineCourse.isHidden = true
        vLineMessage.backgroundColor = .iconColor()
        vLineMessage.isHidden = true
        vLineAcc.backgroundColor = .iconColor()
        vLineAcc.isHidden = true
        imgHome.tintColor = .mainColor()
        imgCourse.tintColor = .iconColor()
        imgMessage.tintColor = .iconColor()
        imgAcc.tintColor = .iconColor()
        lblHome.textColor = .mainColor()
        lblCourse.textColor = .iconColor()
        lblMessage.textColor = .iconColor()
        lblAcc.textColor = .iconColor()
        
        let sb = UIStoryboard(name: "HomeVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? HomeViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBAction func onCourse(_ sender: Any) {
        vLineHome.backgroundColor = .iconColor()
        vLineHome.isHidden = true
        vLineCourse.backgroundColor = .mainColor()
        vLineCourse.isHidden = false
        vLineMessage.backgroundColor = .iconColor()
        vLineMessage.isHidden = true
        vLineAcc.backgroundColor = .iconColor()
        vLineAcc.isHidden = true
        imgHome.tintColor = .iconColor()
        imgCourse.tintColor = .mainColor()
        imgMessage.tintColor = .iconColor()
        imgAcc.tintColor = .iconColor()
        lblHome.textColor = .iconColor()
        lblCourse.textColor = .mainColor()
        lblMessage.textColor = .iconColor()
        lblAcc.textColor = .iconColor()
        
        let sb = UIStoryboard(name: "CourseVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? CourseViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func onSearch(_ sender: Any) {
        let sb = UIStoryboard(name: "SearchVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? SearchViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func onMessage(_ sender: Any) {
        vLineHome.backgroundColor = .iconColor()
        vLineHome.isHidden = true
        vLineCourse.backgroundColor = .iconColor()
        vLineCourse.isHidden = true
        vLineMessage.backgroundColor = .mainColor()
        vLineMessage.isHidden = false
        vLineAcc.backgroundColor = .iconColor()
        vLineAcc.isHidden = true
        imgHome.tintColor = .iconColor()
        imgCourse.tintColor = .iconColor()
        imgMessage.tintColor = .mainColor()
        imgAcc.tintColor = .iconColor()
        lblHome.textColor = .iconColor()
        lblCourse.textColor = .iconColor()
        lblMessage.textColor = .mainColor()
        lblAcc.textColor = .iconColor()
        let sb = UIStoryboard(name: "MessageVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? MessageViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBAction func onAccount(_ sender: Any) {
        vLineHome.backgroundColor = .iconColor()
        vLineHome.isHidden = true
        vLineCourse.backgroundColor = .iconColor()
        vLineCourse.isHidden = true
        vLineMessage.backgroundColor = .iconColor()
        vLineMessage.isHidden = true
        vLineAcc.backgroundColor = .mainColor()
        vLineAcc.isHidden = false
        imgHome.tintColor = .iconColor()
        imgCourse.tintColor = .iconColor()
        imgMessage.tintColor = .iconColor()
        imgAcc.tintColor = .mainColor()
        lblHome.textColor = .iconColor()
        lblCourse.textColor = .iconColor()
        lblMessage.textColor = .iconColor()
        lblAcc.textColor = .mainColor()
        
        let sb = UIStoryboard(name: "AccountVC", bundle: nil)
        if let vc = sb.instantiateInitialViewController() as? AccountViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseTableViewCell") as! CourseTableViewCell
        cell.imgCourse.image = datas[indexPath.row].image
        cell.lblName.text = datas[indexPath.row].name
        cell.lblTrainer.text = datas[indexPath.row].trainer
        cell.lblPrix.text = datas[indexPath.row].prix
        cell.lblTime.text = datas[indexPath.row].time
        cell.selectionStyle = .none
        return cell
    }
}
