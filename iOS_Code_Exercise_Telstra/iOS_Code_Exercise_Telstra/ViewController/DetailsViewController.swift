//
//  DetailsViewController.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 27/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import UIKit
import SDWebImage

let reuserIdetifer = "cellid"

class DetailsViewController: UIViewController{
     let tableView = UITableView()
     var safeArea: UILayoutGuide!
     var arrDetailsModel = [DetailsViewModel]()
    override func viewDidLoad()
    {
       navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
       view.backgroundColor = .white
       safeArea = view.layoutMarginsGuide
       setupView()
       fetchDataFromServer()
    }
    func fetchDataFromServer()
    {
       Service.shared.fetchDescAPI { (data) in
        self.arrDetailsModel = data.rows.map({return DetailsViewModel(details: $0)})
        DispatchQueue.main.async {
        self.tableView.reloadData()
            self.navigationItem.title = data.title
             }
        }
    }
    //MARK:- SetUp View
    func setupView() {
        view.addSubview(tableView)
        tableViewSet()
      }
    func tableViewSet()
       {
           tableView.dataSource = self
           tableView.estimatedRowHeight = 200
           tableView.rowHeight = UITableView.automaticDimension
           tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier:reuserIdetifer)
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
    let cell = tableView.dequeueReusableCell(withIdentifier:reuserIdetifer, for: indexPath)
    let detailslist = arrDetailsModel[indexPath.row]
    guard let detailsViewCell = cell as? DetailsTableViewCell else
    {
        return cell
    }
    detailsViewCell.configureCell(item:detailslist)
    return cell
}
}


