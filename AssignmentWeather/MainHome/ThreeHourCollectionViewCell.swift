//
//  ThreeHourCollectionViewCell.swift
//  AssignmentWeather
//
//  Created by Jaehui Yu on 2/10/24.
//

import UIKit
import SnapKit

final class ThreeHourCollectionViewCell: BaseCollectionViewCell {
    var timeLabel = UILabel()
    var weatherIcon = UIImageView()
    var tempLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(tempLabel)
    }
    
    override func configureView() {
        timeLabel.textAlignment = .center
        weatherIcon.contentMode = .scaleAspectFill
        tempLabel.textAlignment = .center

    }
    
    override func configureConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(8)
            make.centerX.equalTo(contentView)
            make.height.equalTo(16)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.centerX.equalTo(contentView)
            make.size.equalTo(44)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(8)
            make.centerX.equalTo(contentView)
            make.height.equalTo(16)
            make.bottom.equalTo(contentView).inset(8)
        }
    }
}
