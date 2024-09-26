//
//  WeatherViewController.swift
//  
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import UIKit
import Networking

protocol WeatherViewControllerProtocol: AnyObject {
    @MainActor func reload()
    @MainActor func startLoading()
    @MainActor func endLoading()
}

class WeatherViewController: UIViewController {

    private let viewModel: WeatherViewModel

    private lazy var contentView = ContentView()

    // MARK: - Initializers

    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup(with: viewModel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Appears

    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        guard let city = viewModel.weather.name else { return }
        title = "Weather: \(city)".localized
        navigationController?.navigationBar.topItem?.title = ""
    }

    func setup(with viewModel: WeatherViewModel) {
        viewModel.view = self
        viewModel.dataSource.setUp(tableView: contentView.tableView)
        contentView.update(weather: viewModel.weather)
    }
}

extension WeatherViewController: WeatherViewControllerProtocol {
    @MainActor func reload() {
        contentView.tableView.reloadData()
    }

    @MainActor func startLoading() {
        setIsLoading(true)
    }

    @MainActor func endLoading() {
        setIsLoading(false)
    }
}
