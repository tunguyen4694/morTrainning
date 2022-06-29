//
//  TestVC.swift
//  TrainningCourse
//
//  Created by MorHN on 28/06/2022.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var datas: [Course] = courseData()
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var midHeightConstraint: NSLayoutConstraint!
    
    let maxHeaderHeight: CGFloat = 120
    let minHeaderHeight: CGFloat = 60
    let maxMidHeight: CGFloat = 220
    let minMidHeight: CGFloat = 44
    var previousScrollOffSet: CGFloat = 0
    
    @IBOutlet weak var stMid: UIStackView!
    @IBOutlet weak var lblMid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CourseTableViewCell", bundle: nil), forCellReuseIdentifier: "CourseTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerHeightConstraint.constant = maxHeaderHeight
        midHeightConstraint.constant = maxMidHeight
       
        updateHeader()
    }
    
    private func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        let scrollMaxViewHeight = scrollView.frame.height + headerHeightConstraint.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollMaxViewHeight
    }
    
    func setScrollPosition(_ position: CGFloat) {
        tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: position)
    }
    
    func scrollViewDidStopScrolling() {
        // Tính tỉ lệ theo height constraint view nhỏ nhất
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
            self.midHeightConstraint.constant = self.minMidHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.midHeightConstraint.constant = self.maxMidHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func updateHeader() {
        // Tính tỉ lệ theo height constraint view nhỏ nhất
        let range = maxHeaderHeight - minHeaderHeight
        let openAmount = headerHeightConstraint.constant - minHeaderHeight
        let percentage = openAmount/range
        let trailingRange = view.frame.width - imgHeader.frame.minX
        lblHeader.alpha = percentage
        searchTrailingConstraint.constant = trailingRange*(1 - percentage) + 8
        stMid.alpha = percentage
        lblMid.alpha = percentage
    }
}

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        var newMidHeight = midHeightConstraint.constant
        
        if isScrollingDown {
            newHeaderHeight = max(minHeaderHeight, headerHeightConstraint.constant - abs(scrollDiff))
            newMidHeight = max(minMidHeight, midHeightConstraint.constant - abs(scrollDiff))
        } else if isScrollingUp {
            newHeaderHeight = min(maxHeaderHeight, headerHeightConstraint.constant + abs(scrollDiff))
            newMidHeight = min(maxMidHeight, midHeightConstraint.constant + abs(scrollDiff))
        }
        // if newHeaderHeight != headerHeightConstraint.constant ||
        // Lấy điều kiện theo height constraint lớn nhất
        if newMidHeight != midHeightConstraint.constant
        {
            headerHeightConstraint.constant = newHeaderHeight
            midHeightConstraint.constant = newMidHeight
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
