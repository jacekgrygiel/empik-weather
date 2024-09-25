//
//  LoadingScreen.swift
//  
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import UIKit

final class LoadingViewController: UIViewController {
    static let shared = LoadingViewController()

    private enum Const {
        // define any view-related constants here
    }

    override func loadView() {
        view = ContentView()
    }
}

extension LoadingViewController {

    final class ContentView: UIView {
        private let spinner = UIActivityIndicatorView()

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

extension LoadingViewController.ContentView {
    private func addSubviews() {
        addSubview(spinner)
    }

    private func setupSubviews() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

protocol LoadingDisplayProtocol {
    func setIsLoading(_ value: Bool)
}

extension UIViewController: LoadingDisplayProtocol {
    func setIsLoading(_ value: Bool) {
        if value {
            presentInFullScreen(LoadingViewController.shared, animated: false)
        } else {
            LoadingViewController.shared.dismiss(animated: false)
        }
    }
}

extension UIViewController {
  func presentInFullScreen(_ viewController: UIViewController,
                           animated: Bool,
                           completion: (() -> Void)? = nil) {
    viewController.modalPresentationStyle = .overFullScreen
    present(viewController, animated: animated, completion: completion)
  }
}
