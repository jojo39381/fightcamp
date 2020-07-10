//
//  HomeViewController.swift
//  FightCamp-Homework
//
//  Created by Joseph Yeh on 7/8/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, DataManagerDelegate {

    
    let packageCellId = "packageCell"
    var dataManager = DataManager()
    var packageModel: PackageModel?
    
    var packagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = .packageSpacing
        let cv = UICollectionView(frame:.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.layer.cornerRadius = .packageRadius
        cv.backgroundColor = .secondaryBackground
        return cv
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPackageData()
        setupPackageView()
        self.view.backgroundColor = UIColor.secondaryBackground
        
    }
    
    // read all of the packages' data and get a data model back containing details on all the packages.
    func getPackageData() {
        dataManager.delegate = self
        dataManager.readFile(name: "packages")
    }
    
    // setup the main collection view of the packages.
    func setupPackageView() {
        view.addSubview(packagesCollectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: packagesCollectionView)
        view.addConstraintsWithFormat(format: "V:|-[v0]-|", views: packagesCollectionView)
        packagesCollectionView.register(PackagesViewCell.self, forCellWithReuseIdentifier: packageCellId)
        packagesCollectionView.delegate = self
        packagesCollectionView.dataSource = self
        packagesCollectionView.contentInset = UIEdgeInsets(top: .packageSpacing, left: 0, bottom: 0, right: 0)
       
    }
    
    // delegate method that adopts the DataManager Delegate.
    func didReadFile(model: PackageModel) {
        packageModel = model
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packageModel?.packageList.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let packageCell = collectionView.dequeueReusableCell(withReuseIdentifier: packageCellId, for: indexPath) as! PackagesViewCell
        let packageList = packageModel?.packageList
        let package = packageList?[indexPath.item]
        packageCell.packageTitle.text = package?.title.uppercased()
        packageCell.packageDescription.text = package?.desc.capitalized
        packageCell.imageUrls = package?.thumbnail_urls
        packageCell.included = package?.included
        packageCell.excluded = package?.excluded
        let price = package?.price
        packageCell.paymentLabel.text = package?.payment.capitalized
        packageCell.priceLabel.text = "$" + String(price!)
        packageCell.viewPackageButton.setTitle(package?.action.capitalized, for: .normal)
        return packageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideSpacings: CGFloat  = .packageSpacing * 2
        let topSpacing: CGFloat = .packageSpacing
        return CGSize(width:collectionView.frame.width - sideSpacings, height: collectionView.frame.height - topSpacing)
    }
}


