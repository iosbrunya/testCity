//
//  CityListView.swift
//  Testcity
//
//  Created by Brunya on 01.04.2021.
//

import UIKit

final class CityListView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(CityListViewCell.self, forCellReuseIdentifier: "Cell")
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

