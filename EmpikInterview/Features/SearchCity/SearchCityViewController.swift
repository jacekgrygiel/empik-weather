//
//  SearchCityViewController.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import UIKit
import Combine

protocol SearchCityViewControllerProtocol: AnyObject {
    @MainActor func reload()
}

final class SearchCityViewController: UIViewController {

    var viewModel: SearchCityViewModel

    private lazy var contentView = ContentView()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializers

    init(viewModel: SearchCityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: -

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(with: viewModel)
        setupSearch()
    }
}

extension SearchCityViewController {
    func setup(with viewModel: SearchCityViewModel) {
        viewModel.view = self
        viewModel.dataSource.setUp(tableView: contentView.tableView)
    }

    func setupSearch() {
        contentView.searchCompletion = { [viewModel] search in
            Task {
                try await viewModel.search(name: search)
            }
        }
    }
}

extension SearchCityViewController: SearchCityViewControllerProtocol {
    @MainActor func reload() {
        contentView.tableView.reloadData()
    }
}
