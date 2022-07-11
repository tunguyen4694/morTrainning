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
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var btnDelText: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vAll: UIView!
    @IBOutlet weak var vPopular: UIView!
    @IBOutlet weak var vNew: UIView!
    
    var datas: [Course] = courseData()
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var midHeightConstrait: NSLayoutConstraint!
    @IBOutlet weak var searchTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stMid: UIStackView!
    @IBOutlet weak var lblMid: UILabel!
    
    let maxHeaderHeight: CGFloat = 120
    let minHeaderHeight: CGFloat = 60
    let maxMidHeight: CGFloat = 220
    let minMidHeight: CGFloat = 44
    var previousScrollOffSet: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congigUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        headerHeightConstraint.constant = maxHeaderHeight
        midHeightConstrait.constant = maxMidHeight
        updateHeader()
    }
    
    func congigUI() {
        vSearch.layer.cornerRadius = 15
        vAll.layer.cornerRadius = 10
        vPopular.layer.cornerRadius = 10
        vNew.layer.cornerRadius = 10
        
        tableView.separatorStyle = .none
        tfSearch.clearButtonMode = .whileEditing
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CourseTableViewCell", bundle: nil), forCellReuseIdentifier: "CourseTableViewCell")
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        // Tính theo height constraint của view nhỏ nhất trong 2 view thay đổi height constraint
        let scrollMaxViewHeight = scrollView.frame.height + headerHeightConstraint.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollMaxViewHeight
    }
    
    func setScrollPosition(_ potision: CGFloat) {
        tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: potision)
    }
    
    func scrollViewDidStopScrolling() {
        // Tính theo height constraint của view nhỏ nhất trong 2 view thay đổi height constraint
        let range = maxHeaderHeight - minHeaderHeight
        let midPoint = minHeaderHeight + range/2
        
        if headerHeightConstraint.constant > midPoint {
            expandHeader()
        } else {
            collapseHeader()
        }
    }
    
    func collapseHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.midHeightConstrait.constant = self.minMidHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.midHeightConstrait.constant = self.maxMidHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func updateHeader() {
        // Tính theo height constraint của view nhỏ nhất trong 2 view thay đổi height constraint
        let range = maxHeaderHeight - minHeaderHeight
        let openAmount = headerHeightConstraint.constant - minHeaderHeight
        let percentage = openAmount/range
        let trailingRange = view.frame.width - imgUser.frame.minX
        lblHeader.alpha = percentage
        searchTrailingConstraint.constant = trailingRange*(1 - percentage) + 8
        stMid.alpha = percentage
        lblMid.alpha = percentage
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - previousScrollOffSet
        
        let absoluteTop: CGFloat = 0
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        guard canAnimateHeader(scrollView) else { return }
        
        var newHeaderHeight = headerHeightConstraint.constant
        var newMidHeight = midHeightConstrait.constant
        
        if isScrollingDown {
            newHeaderHeight = max(minHeaderHeight, headerHeightConstraint.constant - abs(scrollDiff))
            newMidHeight = max(minMidHeight, midHeightConstrait.constant - abs(scrollDiff))
        } else if isScrollingUp {
            newHeaderHeight = min(maxHeaderHeight, headerHeightConstraint.constant + abs(scrollDiff))
            newMidHeight = min(maxMidHeight, midHeightConstrait.constant + abs(scrollDiff))
        }
        // Lấy điều kiện theo height constraint của view thay đổi lớn nhất
        if newMidHeight != midHeightConstrait.constant {
            headerHeightConstraint.constant = newHeaderHeight
            midHeightConstrait.constant = newMidHeight
            updateHeader()
            setScrollPosition(previousScrollOffSet)
        }
        previousScrollOffSet = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidStopScrolling()
        }
    }
}
