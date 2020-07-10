//
//  FeaturesCell.swift
//  FightCamp-Homework
//
//  Created by Joseph Yeh on 7/9/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation
import UIKit
class FeaturesCell: UITableViewCell {
    
    var featureLabel: UILabel = {
        let label = UILabel()
        label.font = .body
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    // setup the text labels on the list of features/included/excluded.
    func setupView() {
        self.addSubview(featureLabel)
        self.selectionStyle = .none
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: featureLabel)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: featureLabel)
    }
}
