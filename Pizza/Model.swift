//
//  Model.swift
//  Pizza
//
//  Created by Ram Voleti on 20/01/21.
//

import Foundation

struct Pizza: Codable {
    let banner: [String]
    let categoryData: [CategoryData]
}

struct CategoryData: Codable {
    let name: String
    let item: [Item]
}

struct Item: Codable {
    let name: String
    let price: String
    let image: String
}
