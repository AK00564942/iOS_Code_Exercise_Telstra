//
//  ViewController.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 27/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
     let tableView = UITableView()
     var safeArea: UILayoutGuide!
     var amiiboList = [Amiibo]()
        
    override func viewDidLoad() {
        self.title = "AMIBO"
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        let anonymousFunction = {(fetchedAmiiboList:[Amiibo]) in
            DispatchQueue.main.async {
                self.amiiboList = fetchedAmiiboList
                self.tableView.reloadData()
            }
            
        }
        setupView()
        AmiiboAPI.shared.fetchAmiiboList(onCompletion:anonymousFunction)
    }
    
    //MARK:- SetUp View
    func setupView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(AmiibiCell.self, forCellReuseIdentifier:"cellid")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
      }
    }
//MARK:- UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return amiiboList.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
    let list = amiiboList[indexPath.row]
    
    guard let amiibocell = cell as? AmiibiCell else
    {
        return cell
    }
    amiibocell.nameLabel.text = list.name
    amiibocell.nameLabel1.text = list.gameSeries
    if let url =  URL(string:list.image!)
    {
        amiibocell.imageIV.loadImage(from:url)
    }
    return cell
}
}


