//
//  PackageModel.swift
//  FightCamp-Homework
//
//  Created by Joseph Yeh on 7/9/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

// package model contains a list of all the packages that aree defined by a Package struct.
struct PackageModel {
    var packageList : [Package]
}

// package class that contains information about the package.
struct Package {
    var title: String
    var desc: String
    var thumbnail_urls: [String]
    var included: [String]
    var excluded: [String]
    var payment: String
    var price: Int
    var action: String
}
