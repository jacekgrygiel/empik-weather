//
//  SearchCityDataSource.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import UIKit
import Combine

protocol SearchCityDataSourceType: NSObjectProtocol, UITableViewDataSource, UITableViewDelegate  {
    var items: [Any] { set get }
    var selectedCity: PassthroughSubject<String, Never> { get }

    func setUp(tableView: UITableView)
}

final class SearchCityDataSource: NSObject, SearchCityDataSourceType {

    var items: [Any] = []
    let selectedCity = PassthroughSubject<String, Never>()

    func setUp(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            SearchCityTableViewCell.self,
            forCellReuseIdentifier: SearchCityTableViewCell.reusableIdentifier
        )
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchCityTableViewCell.reusableIdentifier,
            for: indexPath
        ) as? SearchCityTableViewCell else {
            return UITableViewCell()
        }

        let item = items[indexPath.row]
        cell.textLabel?.text = ""
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity.send("")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


class SearchCityTableViewCell: UITableViewCell, ReusableIdentifier {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

