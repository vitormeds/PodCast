//
//  LanguageListViewController.swift
//  PodCast
//
//  Created by Vitor on 17/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class LanguageListViewController: UIViewController {
    
    var delegate: ListUpdateDelegate!
    
    var languages = [String]()
    var filteredLanguages = [String]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = UIColor.primary
        tableView.backgroundColor = UIColor.primary
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var searchBar: SearchBar = {
        let searchBar = SearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = R.string.localizable.buscar()
        searchBar.cancelTitle = R.string.localizable.fechar()
        searchBar.showsCancelButton = false
        searchBar.barTintColor = UIColor.primary
        searchBar.tintColor = UIColor.primary
        searchBar.backgroundColor = UIColor.primary
        searchBar.delegate = self
        searchBar.layer.borderColor = UIColor.primary.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.cancelButtonColor = UIColor.secondary
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.primary
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.voltar(), style: .done, target: self, action: #selector(performBack))
        setupViews()
        loadData()
    }
    
    func loadData() {
        self.languages = ["Portugues","Ingles","Espanhol"]
        self.filteredLanguages = self.languages
        self.tableView.reloadData()
    }
    
    func setupViews() {
        
        view.addSubview(searchBar)
        searchBar.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func performBack() {
        delegate.loadData()
        dismiss(animated: true)
    }
    
}

extension LanguageListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = UIColor.primary
        cell.tintColor = UIColor.secondary
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.textLabel?.textColor = UIColor.secondary
        cell.textLabel?.text = filteredLanguages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UserInfoDAO.add(language: filteredLanguages[indexPath.row])
        performBack()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLanguages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension LanguageListViewController: UISearchBarDelegate,UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let searchText = ((searchBar.text ?? "") as NSString).replacingCharacters(in: range, with: text)
        if !searchText.isEmpty {
            filteredLanguages = languages.filter({ ($0.contains(searchText)) })
        }
        else {
            filteredLanguages = languages
        }
        tableView.reloadData()
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
        searchBar.showsCancelButton = false
        filteredLanguages = languages
        tableView.reloadData()
    }
}
