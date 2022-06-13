//
//  ViewController.swift
//  Holiday
//
//  Created by 林大屍 on 2022/5/31.
//

import UIKit
import SnapKit

struct Contact {
    let name:String
    let jobTitle:String
    let country:String
}

class ContactAPI {
    static func getContacts() -> [Contact] {
        let contacts = [
            Contact(name: "Kelly Goodwin", jobTitle: "Designer", country: "bo"),
            Contact(name: "Mohammad Hussain", jobTitle: "SEO Specialist", country: "be"),
            Contact(name: "John Young", jobTitle: "Interactive Designer", country: "af"),
            Contact(name: "Tamilarasi Mohan", jobTitle: "Architect", country: "al"),
            Contact(name: "Kim Yu", jobTitle: "Economist", country: "br"),
            Contact(name: "Derek Fowler", jobTitle: "Web Strategist", country: "ar"),
            Contact(name: "Shreya Nithin", jobTitle: "Product Designer", country: "az"),
            Contact(name: "Emily Adams", jobTitle: "Editor", country: "bo"),
            Contact(name: "Aabidah Amal", jobTitle: "Creative Director", country: "au")
        ]
        return contacts
    }
}






class ViewController: UIViewController {
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let contacts = ContactAPI.getContacts()
    
    var filteredContacts = [Contact]()
    
    
    let tableView: UITableView = {
        let myTableView = UITableView()
        myTableView.register(HolidayCell.self, forCellReuseIdentifier: HolidayCell.identifier)
        //        myTableView.isScrollEnabled = false
        myTableView.rowHeight = UITableView.automaticDimension
        return myTableView
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        setUpTableView()
        setUpView()
        setUpSearchBar()
        
        title = "mmdd"
        
    }
    
    func setUpSearchBar() {
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = UIColor.systemMint
        
    }
    
    
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = searchController.searchBar
        
        
    }
    
    func setUpView() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    private func filterContacts(for searchText: String) {
        filteredContacts = contacts.filter { contact in
            return
            contact.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    
    
    
    
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredContacts.count
        }
        
        return contacts.count
    }
    
    //render the cell and display data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HolidayCell.identifier,
                                                 for: indexPath) as! HolidayCell
        
        let contact: Contact
        if searchController.isActive && searchController.searchBar.text != "" {
            contact = filteredContacts[indexPath.row]
        } else {
            contact = contacts[indexPath.row]
        }
        
        cell.titleLabel.text = contact.name
        cell.descriptionLabel.text = contact.jobTitle
        
        return cell
    }
    
    
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContacts(for: searchController.searchBar.text ?? "" )
    }
    
}



