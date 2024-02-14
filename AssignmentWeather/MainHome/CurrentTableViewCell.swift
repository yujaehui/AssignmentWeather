//
//  CurrentTableViewCell.swift
//  AssignmentWeather
//
//  Created by Jaehui Yu on 2/10/24.
//

import UIKit

class CurrentTableViewCell: BaseTableViewCell {
    let cityLabel = UILabel()
    let tempLabel = UILabel()
    let weatherLabel = UILabel()
    let lowestHighestLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(cityLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(weatherLabel)
        contentView.addSubview(lowestHighestLabel)
    }
    
    override func configureView() {
        cityLabel.textAlignment = .center
        cityLabel.font = .systemFont(ofSize: 30, weight: .regular)
        tempLabel.textAlignment = .center
        tempLabel.font = .systemFont(ofSize: 100, weight: .thin)
        weatherLabel.textAlignment = .center
        weatherLabel.font = .systemFont(ofSize: 20, weight: .medium)
        lowestHighestLabel.textAlignment = .center
        lowestHighestLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        
    }
    
    override func configureConstraints() {
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(8)
            make.centerX.equalTo(contentView)
            make.height.equalTo(30)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(8)
            make.centerX.equalTo(contentView)
            make.height.equalTo(100)
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(8)
            make.centerX.equalTo(contentView)
            make.height.equalTo(20)
        }
        
        lowestHighestLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom).offset(8)
            make.centerX.equalTo(contentView)
            make.height.equalTo(20)
            make.bottom.equalTo(contentView).inset(8)
        }
    }
}
