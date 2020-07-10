//
//  PackageData.swift
//  FightCamp-Homework
//
//  Created by Joseph Yeh on 7/9/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

// used for decoding the json file data
struct PackageData : Decodable {
    let title: String
    let desc: String
    let thumbnail_urls: [String]
    let included: [String]
    let excluded: [String]?
    let payment: String
    let price: Int
    let action: String
    
    
}
