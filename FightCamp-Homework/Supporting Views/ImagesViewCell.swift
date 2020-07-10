//
//  ImagesViewCell.swift
//  FightCamp-Homework
//
//  Created by Joseph Yeh on 7/8/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class ImagesViewCell: UICollectionViewCell {
    
    var previewImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    // setup views and subviews.
    func setupViews() {
        self.layer.cornerRadius = .thumbnailRadius
        self.layer.borderWidth = .thumbnailBorderWidth
        self.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        setupThumbnail()
    }
    
    // setup the individual thumbnails and styles.
    func setupThumbnail() {
        self.addSubview(previewImage)
        previewImage.layer.cornerRadius = .thumbnailRadius
        previewImage.clipsToBounds = true
        previewImage.frame = self.contentView.frame
    }
    
    // check if isSelected is changed, if so, change the border color.
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.thumbnailBorder(selected: true).cgColor
            } else {
                layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
            }
        }
    }
    
    // set the thumbnail image to nil so that it can bee reused properly.
    override func prepareForReuse() {
        previewImage.image = nil
    }

  
}
