//
//  CollectionViewCell.swift
//  RxTestApp
//
//  Created by HINOMORI HIROYA on 2018/06/21.
//  Copyright © 2018年 HINOMORI HIROYA. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var itemWidthConstraint: NSLayoutConstraint!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let parent = superview {
            itemWidthConstraint.constant = parent.frame.size.width
        }
    }
    
    func register(data: ContentData) {
        if data.stop {
            statusView.backgroundColor = .orange
        } else {
            statusView.backgroundColor = .blue
        }
        titleLabel.text = data.title
        subTitleLabel.text = data.story
        authorLabel.text = data.writer
        dateLabel.text = convertTransitDate(date: data.updateAt)
    }
    
    private func convertTransitDate(date: Date) -> String {
        let delta = -date.timeIntervalSinceNow
        let day = delta / (24.0 * 60.0 * 60.0)
        if day > 1 {
            return String(Int(day)) + "d"
        }
        let hour = delta / (60.0 * 60.0)
        if hour > 1 {
            return String(Int(hour)) + "h"
        }
        let min = delta / 60.0
        return String(Int(min)) + "m"
    }
}
