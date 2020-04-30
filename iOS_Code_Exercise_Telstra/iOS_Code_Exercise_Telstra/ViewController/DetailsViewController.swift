//
//  DetailsViewController.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 27/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController{
    
     let tableView = UITableView()
     var safeArea: UILayoutGuide!
     var arrDetailsModel = [DetailsViewModel]()
        
    override func viewDidLoad() {
      navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
               view.backgroundColor = .white
               safeArea = view.layoutMarginsGuide
               setupView()
               Service.shared.fetchDescAPI { (status, data) in
               if status {
                   self.arrDetailsModel = data.rows.map({return DetailsViewModel(details: $0)})
                   
                   DispatchQueue.main.async {
                   self.tableView.reloadData()
                   self.title = data.title
                   }
               }
                   }
      
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
extension DetailsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrDetailsModel.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
    let list = arrDetailsModel[indexPath.row]
    
    guard let amiibocell = cell as? AmiibiCell else
    {
        return cell
    }
    amiibocell.titlelbl.text = list.title
    amiibocell.desclbl.text = list.description
    if let imageUrl = list.imageHref
    {
        if let url =  URL(string:imageUrl)
        {
            amiibocell.imageIV.loadImage(from:url)
        }
    }
    
    return cell
}
}


