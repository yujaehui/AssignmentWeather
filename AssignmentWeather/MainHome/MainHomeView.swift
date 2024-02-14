//
//  MainHomeView.swift
//  AssignmentWeather
//
//  Created by Jaehui Yu on 2/10/24.
//

import UIKit
import SnapKit

final class MainHomeView: BaseView {
    let currentWeatherView = CurrentView()
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(CurrentTableViewCell.self, forCellReuseIdentifier: CurrentTableViewCell.identifier)
        view.register(ThreeHourTableViewCell.self, forCellReuseIdentifier: ThreeHourTableViewCell.identifier)
        view.register(FiveDayTableViewCell.self, forCellReuseIdentifier: FiveDayTableViewCell.identifier)
        view.register(MapTableViewCell.self, forCellReuseIdentifier: MapTableViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(currentWeatherView)
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        currentWeatherView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(210)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

