//
//  SearchCityViewController+ContentView.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import UIKit

extension SearchCityViewController.ContentView {
    private enum Const {
        // define any view-related constants here
    }
}

extension SearchCityViewController {
    final class ContentView: UIView {
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Results"
            return label
        }()

        let tableView = UITableView()

        private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, tableView])

        init() {
            super.init(frame: .zero)
            addSubviews()
            setupSubviews()
            setupLayout()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { nil }
    }
}

extension SearchCityViewController.ContentView {
    private func addSubviews() {
        addSubview(stackView)
    }

    private func setupSubviews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        backgroundColor = .white
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
