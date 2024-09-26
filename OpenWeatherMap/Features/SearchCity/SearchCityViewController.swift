//
//  SearchCityViewController.swift
//  
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import UIKit
import Combine

@MainActor protocol SearchCityViewControllerProtocol: AnyObject {
    func reload()
    func startLoading()
    func endLoading()
    func presentError()
}

final class SearchCityViewController: UIViewController {

    private var viewModel: SearchCityViewModel

    private lazy var contentView = ContentView()
    private var cancellables = Set<AnyCancellable>()
    private let searchController = UISearchController()
    private let debouner = Debouncer(delay: 1.0)

    // MARK: - Initializers

    init(viewModel: SearchCityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Appears

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(with: viewModel)
        setupSearch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Search City".localized
    }
}

extension SearchCityViewController {
    func setup(with viewModel: SearchCityViewModel) {
        viewModel.view = self
        viewModel.dataSource.setUp(tableView: contentView.tableView)
    }

    func setupSearch() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
}

extension SearchCityViewController: SearchCityViewControllerProtocol {
    
    @MainActor func reload() {
        contentView.tableView.reloadData()
    }

    @MainActor func startLoading() {
        setIsLoading(true)
    }
    
    @MainActor func endLoading() {
        setIsLoading(false)
    }

    @MainActor func presentError() {
        let alertController = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debouner.debounce {
            try await self.viewModel.search(name: searchText)
            self.contentView.tableView.reloadData()
        }
    }
}
