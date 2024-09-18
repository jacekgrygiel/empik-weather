//
//  WeatherViewController+ContentView.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import UIKit
import Networking

extension WeatherViewController.ContentView {
    private enum Const {
        // define any view-related constants here
    }
}

extension WeatherViewController {
    final class ContentView: UIView {
        private let temperatureLabel = UILabel()
        private let weatherConditionLabel = UILabel()
        let tableView = UITableView()

        init() {
            super.init(frame: .zero)
            addSubviews()
            setupSubviews()
            setupLayout()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { nil }
        
        func update(weather: WeatherResponse.WeatherData) {
            let main = weather.main

            // Update temperature label with color coding
            let temperature = main.temp
            temperatureLabel.text = "\(temperature) °C"
            temperatureLabel.textColor = colorForTemperature(temperature)

            // Update weather condition label
            weatherConditionLabel.text = weather.weather.compactMap { $0.main }.joined(separator: ", ")

        }
    }
}

extension WeatherViewController.ContentView {
    private func addSubviews() {
        addSubview(temperatureLabel)
        addSubview(weatherConditionLabel)
        addSubview(tableView)
    }

    private func setupSubviews() {

        backgroundColor = .white

        temperatureLabel.font = .systemFont(ofSize: 32)
        temperatureLabel.textAlignment = .center

        weatherConditionLabel.font = .systemFont(ofSize: 24)
        weatherConditionLabel.textAlignment = .center

        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupLayout() {

        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            weatherConditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            weatherConditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            tableView.topAnchor.constraint(equalTo: weatherConditionLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
