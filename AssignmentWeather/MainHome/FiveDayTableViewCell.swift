//
//  FiveDayTableViewCell.swift
//  AssignmentWeather
//
//  Created by Jaehui Yu on 2/10/24.
//

import UIKit

class FiveDayTableViewCell: BaseTableViewCell {
    let stackView = UIStackView()
    let dateLabel = UILabel()
    let weatherIcon = UIImageView()
    let lowestTempLabel = UILabel()
    let highestTempLabel = UILabel()
    
    
    override func configureHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(weatherIcon)
        stackView.addArrangedSubview(lowestTempLabel)
        stackView.addArrangedSubview(highestTempLabel)
    }
    
    override func configureView() {
        stackView.distribution = .equalCentering
        weatherIcon.contentMode = .scaleAspectFit
        lowestTempLabel.textColor = .darkGray
        highestTempLabel.textAlignment = .right
    }
    
    override func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(contentView)
        }
    }
}
