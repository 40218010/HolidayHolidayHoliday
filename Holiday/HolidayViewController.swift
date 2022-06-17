//
//  HolidayViewController.swift
//  Holiday
//
//  Created by 林大屍 on 2022/6/10.
//

import UIKit
import SnapKit

class HolidayViewController: UIViewController {
    
    
    var listOfHolidays = [HolidayDetail]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHolidays[0].country.name) Holidays 2022 👻"
            }
        }
    }
    
    let search = UISearchController(searchResultsController: nil)
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HolidayCell.self, forCellReuseIdentifier: HolidayCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        
        title = "zzz"
        
        setUpTableView()
        setUpSearchBar()
        setUpView()
        
    }
    
    func setUpSearchBar() {
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        
        search.searchBar.barTintColor = .systemCyan
        search.searchBar.tintColor = .white
        
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = search.searchBar
    }
    
    func setUpView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}


// MARK: UITableViewDataSource
extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHolidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HolidayCell.identifier,
                                                 for: indexPath) as! HolidayCell
        let holiday = listOfHolidays[indexPath.row]
        cell.titleLabel.text = holiday.name
        cell.descriptionLabel.text = holiday.date.iso
        
        return cell
    }
}

extension HolidayViewController : UITableViewDelegate {
    
}



// MARK: UISearchBarDelegate
extension HolidayViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        let holidayRequest = HttpRequest(countryCode: searchBarText)
        holidayRequest.getMethod { [weak self] result in
            switch result {
            case .success(let holidays):
                self?.listOfHolidays = holidays
            case .failure(let error):
                print(error)
            }
        }

        


//        let holidayRequest = HolidayRequest(countryCode: searchBarText)
//        holidayRequest.getHolidays { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let holidays):
//                self?.listOfHolidays = holidays
//            }
//        }
        
    }
}
