//
//  WeatherDataSourceType.swift
//  
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import UIKit
import Combine
import Networking

protocol WeatherDataSourceType: NSObjectProtocol, UITableViewDataSource, UITableViewDelegate  {
    var items: [WeatherForecastResponse.ForecastItem] { set get }
    var selectedCity: PassthroughSubject<City, Never> { get }

    func setUp(tableView: UITableView)
}

final class WeatherDataSource: NSObject, WeatherDataSourceType {

    var items: [WeatherForecastResponse.ForecastItem] = []
    let selectedCity = PassthroughSubject<City, Never>()

    func setUp(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            ForecastWeatherTableViewCell.self,
            forCellReuseIdentifier: ForecastWeatherTableViewCell.reusableIdentifier
        )
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ForecastWeatherTableViewCell.reusableIdentifier,
            for: indexPath
        ) as? ForecastWeatherTableViewCell else {
            return UITableViewCell()
        }

        let item = items[indexPath.row]
        cell.textLabel?.attributedText = attributedTextForTemperature(dateString: Date(timeIntervalSince1970: TimeInterval(item.dt)).shorten(), temp: item.main.temp)
        return cell
    }

    func attributedTextForTemperature(dateString: String, temp: Double) -> NSAttributedString {
        let fullText = "\(dateString), \(temp) °C"
        let attributedString = NSMutableAttributedString(string: fullText)
        let tempRange = (fullText as NSString).range(of: "\(temp) °C")
        attributedString.addAttribute(.foregroundColor, value: colorForTemperature(temp), range: tempRange)
        return attributedString
    }

    private func colorForTemperature(_ temperature: Double) -> UIColor {
        switch temperature {
        case ..<10:
            return .blue
        case 10...20:
            return .black
        default:
            return .red
        }
    }

}

private extension Date {
    func shorten() -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
}

class ForecastWeatherTableViewCell: UITableViewCell, ReusableIdentifier {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}
