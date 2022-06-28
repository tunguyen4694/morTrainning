//
//  TestVC.swift
//  TrainningCourse
//
//  Created by MorHN on 28/06/2022.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var stHeader: UIStackView!
    @IBOutlet weak var heightHeaderConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightTopContraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var iconHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var vTop: UIView!
    
    let maxHeaderHeight: CGFloat = 153
    let minHeaderHeight: CGFloat = 44
    
    let maxTopHeight: CGFloat = 106
    let minTopHeight: CGFloat = 0
    
    var previousScrollOffSet: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        heightHeaderConstraint.constant = maxHeaderHeight
        heightTopContraint.constant = maxTopHeight
        iconHeightConstraint.constant = 32
        updateHeader()
    }
    
    private func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        let scrollMaxViewHeight = scrollView.frame.height + heightHeaderConstraint.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollMaxViewHeight
    }
    
    func setScrollPosition(_ position: CGFloat) {
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: position)
    }
    
    func scrollViewDidStopScrolling() {
        let range = maxHeaderHeight - minHeaderHeight
        let midPoint = minHeaderHeight + range/2
        
        if heightHeaderConstraint.constant > midPoint {
            expandHeader()
        } else {
            collapseHeader()
        }
    }
    
    func collapseHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.heightHeaderConstraint.constant = self.minHeaderHeight
            self.heightTopContraint.constant = self.minTopHeight
            self.iconHeightConstraint.constant = 24
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.heightHeaderConstraint.constant = self.maxHeaderHeight
            self.heightTopContraint.constant = self.maxTopHeight
            self.iconHeightConstraint.constant = 32
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func updateHeader() {
        let range = maxHeaderHeight - minHeaderHeight
        let openAmount = heightHeaderConstraint.constant - minHeaderHeight
        let percentage = openAmount/range
        stHeader.alpha = percentage
        progressView.alpha = percentage
        vTop.alpha = percentage
    }
}

extension TestViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - previousScrollOffSet
        
        let absoluteTop: CGFloat = 0
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        guard canAnimateHeader(scrollView) else { return }
        
        var newHeaderHeight = heightHeaderConstraint.constant
        var newTopHeight = heightTopContraint.constant
        var newIconHeight = iconHeightConstraint.constant
        
        if isScrollingDown {
            newHeaderHeight = max(minHeaderHeight, heightHeaderConstraint.constant - abs(scrollDiff))
            newTopHeight = max(minTopHeight, heightTopContraint.constant - abs(scrollDiff))
            newIconHeight = max(24, iconHeightConstraint.constant - abs(scrollDiff))
        } else if isScrollingUp {
            newHeaderHeight = min(maxHeaderHeight, heightHeaderConstraint.constant + abs(scrollDiff))
            newTopHeight = min(maxTopHeight, heightTopContraint.constant + abs(scrollDiff))
            newIconHeight = min(32, iconHeightConstraint.constant + abs(scrollDiff))
        }
        if newHeaderHeight != heightHeaderConstraint.constant && newTopHeight != heightTopContraint.constant {
            heightHeaderConstraint.constant = newHeaderHeight
            heightTopContraint.constant = newTopHeight
            iconHeightConstraint.constant = newIconHeight
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
