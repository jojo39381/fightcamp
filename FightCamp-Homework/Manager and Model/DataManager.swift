//
//  File.swift
//  FightCamp-Homework
//
//  Created by Joseph Yeh on 7/9/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

// protocol to define a delegate that is used to pass the package model back.
protocol DataManagerDelegate {
    func didReadFile(model: PackageModel)
}

// manager to decode json file and call a delegate method to pass back the data model.
struct DataManager {
    var delegate: DataManagerDelegate?
    
    // read the local json file.
    func readFile(name: String) {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile:bundlePath).data(using: .utf8) {
                parse(jsonData: jsonData)
            }
        } catch {
            print(error)
        }
    }

    //parse the json file and call delegate method.
    private func parse(jsonData: Data) {
        do  {
            let decodedData = try JSONDecoder().decode([PackageData].self, from: jsonData)
            var packageList = [Package]()
            for package in decodedData {
                let package = Package(title: package.title, desc: package.desc, thumbnail_urls: package.thumbnail_urls, included: package.included, excluded: package.excluded ?? [String](), payment: package.payment, price: package.price, action: package.action)
                packageList.append(package)
            }
            let packageModel = PackageModel(packageList:packageList)
            delegate?.didReadFile(model: packageModel)
        } catch {
            print(error)
        }
    }
}
