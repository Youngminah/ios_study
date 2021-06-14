//
//  Models.swift
//  MyTableView
//
//  Created by meng on 2021/06/14.
//

import Foundation

enum CellModel{
    case collectionView(models: [CollectionTableCellModel], rows: Int)
    case list(models: [ListCellModel])
}


struct ListCellModel{
    let title: String
}

struct CollectionTableCellModel {
    let title: String
    let imageName: String
}
