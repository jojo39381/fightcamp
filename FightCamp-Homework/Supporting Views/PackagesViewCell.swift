//
//  PackagesViewCellCollectionViewCell.swift
//  FightCamp-Homework
//
//  Created by Joseph Yeh on 7/8/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class PackagesViewCell: UICollectionViewCell{

    
    
    var imageCellId = "imageCellId"
    var featureCellId = "featureCellId"
    var featuresList: [String]?
    var included: [String]?
    var excluded: [String]?
    var imageUrls: [String]? {
        didSet {
            let url = NSURL(string: imageUrls![0])
            let data = NSData(contentsOf: url! as URL)
            thumbnail.image = UIImage(data: data! as Data)
            self.imagesCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
        }
    }
    
    var packageTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.title
        label.textColor = UIColor.brandRed
        return label
    }()
    
    var packageDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.body
        label.numberOfLines = 0
        return label
    }()
    
    var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        let cv = UICollectionView(frame:.zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        return cv
    }()
    
    var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = .thumbnailRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var featuresView: UITableView = {
        let tb = UITableView()
        return tb
    }()
    
    var paymentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.body
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.price
        return label
    }()
    
    var viewPackageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brandRed
        button.layer.cornerRadius = .buttonRadius
        button.titleLabel?.font = .button
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    // setup subviews and add constraints.
    func setupViews() {
        self.backgroundColor = .primaryBackground
        self.layer.cornerRadius = 12
        addSubview(packageTitle)
        addSubview(packageDescription)
        addSubview(thumbnail)
        addSubview(imagesCollectionView)
        addSubview(featuresView)
        addSubview(paymentLabel)
        addSubview(priceLabel)
        addSubview(viewPackageButton)
        addConstraintsWithFormat(format:"H:|-24-[v0]-24-|", views: packageTitle)
        addConstraintsWithFormat(format:"H:|-24-[v0]-24-|", views: packageDescription)
        addConstraintsWithFormat(format:"H:|-24-[v0]-24-|", views: thumbnail)
        addConstraintsWithFormat(format:"H:|-24-[v0]-24-|", views: imagesCollectionView)
        addConstraintsWithFormat(format:"H:|-24-[v0]-24-|", views: featuresView)
        addConstraintsWithFormat(format:"H:|-24-[v0]-24-|", views: paymentLabel)
        addConstraintsWithFormat(format:"H:|-24-[v0]-24-|", views: priceLabel)
        addConstraintsWithFormat(format:"H:|-24-[v0]-24-|", views: viewPackageButton)
        addConstraintsWithFormat(format:"V:|-24-[v0]-24-[v1]-24-[v2(240)]-4-[v3(75)]-24-[v4]-24-[v5(16)]-[v6(26)]-24-[v7(40)]-24-|", views: packageTitle, packageDescription, thumbnail, imagesCollectionView, featuresView, paymentLabel, priceLabel, viewPackageButton)
        setupImageCollectionView()
        setupFeaturesView()

    }

    
    // setup the image collection view (thumbnails).
    func setupImageCollectionView() {
        imagesCollectionView.register(ImagesViewCell.self, forCellWithReuseIdentifier: imageCellId)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.backgroundColor = .primaryBackground
    }
    
    // setup the table view of the list of features that are included and excluded in each package.
    func setupFeaturesView() {
        featuresView.register(FeaturesCell.self, forCellReuseIdentifier: featureCellId)
        featuresView.delegate = self
        featuresView.dataSource = self
        featuresView.isScrollEnabled = false
        featuresView.separatorStyle = .none
    }
}


extension PackagesViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return imageUrls?.count ?? 4
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath) as! ImagesViewCell
         let url = NSURL(string: imageUrls![indexPath.item])
         let data = NSData(contentsOf: url! as URL)
         imageCell.previewImage.image = UIImage(data: data! as Data)
        
         return imageCell
     }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacings: CGFloat = .thumbnailSpacing * 3
        let width = (collectionView.frame.width - cellSpacings) / 4
        return CGSize(width:width, height: collectionView.frame.height)
     }
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath) as! ImagesViewCell
         imageCell.isSelected = true
         let url = NSURL(string: imageUrls![indexPath.item])
         let data = NSData(contentsOf: url! as URL)
         thumbnail.image = UIImage(data: data! as Data)
         
     }
}

extension PackagesViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let includedCount = included?.count
        let excludedCount = excluded?.count
        return includedCount! + excludedCount!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let featureCell = tableView.dequeueReusableCell(withIdentifier: featureCellId, for: indexPath) as! FeaturesCell
        let featuresList = included! + excluded!
        let feature = featuresList[indexPath.item]
        if (excluded!.contains(feature)) {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: feature.capitalized)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            featureCell.featureLabel.attributedText = attributeString
            featureCell.featureLabel.textColor = UIColor.disabledLabel
        }
        else {
            featureCell.featureLabel.text = feature.capitalized
        }
        
        return featureCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/8
    }
}
