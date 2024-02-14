//
//  ThreeHourTableViewCell.swift
//  AssignmentWeather
//
//  Created by Jaehui Yu on 2/10/24.
//

import UIKit
import SnapKit
import Kingfisher

final class ThreeHourTableViewCell: BaseTableViewCell {
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.register(ThreeHourCollectionViewCell.self, forCellWithReuseIdentifier: ThreeHourCollectionViewCell.identifier)
        return view
    }()
    
    var threeHourList: [List] = []
    
    private static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 75, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }

    override func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    override func configureView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(108)
            make.edges.equalTo(contentView)
        }
    }
    
    func dateFormatter(_ dateString: String) -> String {
        let dateString = dateString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH'시'"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return ""
        }
    }
    
    func calculateTemp(_ temp: Double) -> String {
        let calculateTemp = temp - 273.15
        let IntTemp = Int(calculateTemp)
        return String(IntTemp)
    }
}

extension ThreeHourTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return threeHourList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeHourCollectionViewCell.identifier, for: indexPath) as! ThreeHourCollectionViewCell
        cell.timeLabel.text = dateFormatter(threeHourList[indexPath.row].dtTxt)
        let url = URL(string: "https://openweathermap.org/img/wn/\(threeHourList[indexPath.row].weather[0].icon).png")
        cell.weatherIcon.kf.setImage(with: url)
        cell.tempLabel.text = calculateTemp(threeHourList[indexPath.row].main.temp) + "°"
        return cell
    }
}
