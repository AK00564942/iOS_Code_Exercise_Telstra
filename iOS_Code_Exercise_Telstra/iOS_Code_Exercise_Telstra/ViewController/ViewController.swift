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
    let jsonList = ["Anuj","Anuj1","Anuj2","Anuj3"]
        
    override func viewDidLoad() {
        self.title = "About Canada"
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cellid")
        setupView()
        detailsAPI.shared.fetchDescAPI()
    }
    
    //MARK:- SetUp View
    func setupView() {
        view.addSubview(tableView)
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
    return jsonList.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
    let list = jsonList[indexPath.row]
    cell.textLabel?.text = list
    return cell
}
}


