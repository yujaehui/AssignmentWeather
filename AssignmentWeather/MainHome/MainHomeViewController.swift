//
//  MainHomeViewController.swift
//  AssignmentWeather
//
//  Created by Jaehui Yu on 2/10/24.
//

import UIKit
import SnapKit

enum SectionType: String, CaseIterable {
    //case Current
    case ThreeHour
    case FiveDay
    case Map
}

final class MainHomeViewController: UIViewController {
    let mainHomeView = MainHomeView()
    var currentList: [CurrentWeatherModel] = []
    var threeHourList: [List] = []
    var fiveDayList: [List] = []
    
    override func loadView() {
        super.loadView()
        self.view = mainHomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainHomeView.tableView.dataSource = self
        mainHomeView.tableView.delegate = self
        
        let group = DispatchGroup()
        
        group.enter()
        WeatherAPIManager.shared.request(type: CurrentWeatherModel.self, api: .currentWeather(lat: 35.133331, lon: 128.699997)) { response in
            self.currentList = [response]
            group.leave()
        }
        
        group.enter()
        WeatherAPIManager.shared.request(type: WeatherModel.self, api: .weather(lat: 35.133331, lon: 128.699997)) { response in
            self.threeHourList = Array(response.list.prefix(24))
            self.fiveDayList = response.list.filter { $0.dtTxt.hasSuffix("12:00:00") }
            print(self.threeHourList[0].dtTxt)
            group.leave()
        }
        
        group.notify(queue: .main) { [self] in
            mainHomeView.tableView.reloadData()
            mainHomeView.currentWeatherView.cityLabel.text = currentList[0].name
            mainHomeView.currentWeatherView.tempLabel.text = calculateTemp(currentList[0].main.temp) + "°"
            mainHomeView.currentWeatherView.weatherLabel.text = currentList[0].weather[0].main
            mainHomeView.currentWeatherView.lowestHighestLabel.text = "최고: \(calculateTemp(fiveDayList[0].main.tempMin))°" + "  " + "최저: \(calculateTemp(fiveDayList[0].main.tempMax))°"
        }
    }
    
    func dateFormatter(_ dateString: String) -> String {
        let dateTimeString = dateString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateTimeString) else { return "" }
        let calendar = Calendar.current
        let dayOfWeekIndex = calendar.component(.weekday, from: date)
        let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
        let dayOfWeek = weekdays[dayOfWeekIndex - 1]
        
        if calendar.isDateInToday(date) {
            return "오늘"
        } else {
            return dayOfWeek
        }
    }
    
    func calculateTemp(_ temp: Double) -> String {
        let calculateTemp = temp - 273.15
        let IntTemp = Int(calculateTemp)
        return String(IntTemp)
    }
}

extension MainHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SectionType.allCases[section] {
            //case .Current: return currentList.count
        case .ThreeHour: return 1
        case .FiveDay: return fiveDayList.count
        case .Map: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch SectionType.allCases[section] {
            //case .Current: return ""
        case .ThreeHour: return "시간별 일기예보"
        case .FiveDay: return "5일간의 일기예보"
        case .Map: return "위치"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionType.allCases[indexPath.section] {
            //        case .Current:
            //            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentTableViewCell.identifier, for: indexPath) as! CurrentTableViewCell
            //            cell.cityLabel.text = currentList[indexPath.row].name
            //            cell.tempLabel.text = calculateTemp(currentList[indexPath.row].main.temp) + "°"
            //            cell.weatherLabel.text = currentList[indexPath.row].weather[0].main
            //            cell.lowestHighestLabel.text = "최고: \(calculateTemp(fiveDayList[indexPath.row].main.tempMin))°" + "  " + "최저: \(calculateTemp(fiveDayList[indexPath.row].main.tempMax))°"
            //            return cell
        case .ThreeHour:
            let cell = tableView.dequeueReusableCell(withIdentifier: ThreeHourTableViewCell.identifier, for: indexPath) as! ThreeHourTableViewCell
            cell.threeHourList = threeHourList
            cell.collectionView.reloadData()
            return cell
        case .FiveDay:
            let cell = tableView.dequeueReusableCell(withIdentifier: FiveDayTableViewCell.identifier, for: indexPath) as! FiveDayTableViewCell
            cell.dateLabel.text = dateFormatter(fiveDayList[indexPath.row].dtTxt)
            let url = URL(string: "https://openweathermap.org/img/wn/\(fiveDayList[indexPath.row].weather[0].icon).png")
            cell.weatherIcon.kf.setImage(with: url)
            cell.lowestTempLabel.text = "최저: \(calculateTemp(fiveDayList[indexPath.row].main.tempMin))°"
            cell.highestTempLabel.text = "최고: \(calculateTemp(fiveDayList[indexPath.row].main.tempMax))°"
            return cell
        case .Map:
            let cell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as! MapTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch SectionType.allCases[indexPath.section] {
        case .FiveDay: return 60
        default: return UITableView.automaticDimension

        }
    }
}
