//
//  DetailsViewController.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 27/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import UIKit
import SDWebImage

var refresh = UIRefreshControl()
let reuserIdetifer = "cell"
class DetailsViewController: UIViewController, UITableViewDelegate{
     let tableView = UITableView()
     var safeArea: UILayoutGuide!
     var arrDetailsModel = [DetailsViewModel]()
     var isScrolling = false
     var pendingUpdate = false
    override func viewDidLoad()
    {
       refreshAction()
       safeArea = view.layoutMarginsGuide
       setupView()
        if !self.isScrolling
        {
            self.fetchDataFromServer()
        } else
        {
            self.pendingUpdate = true
        }
    }
    @objc func refreshData(sender:UIRefreshControl)
    {
        fetchDataFromServer()
        sender.endRefreshing()
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
    func refreshAction()
    {
        if #available(iOS 10.0, *)
            {
            tableView.refreshControl = refresh
            }
        else
            {
             tableView.addSubview(refresh)
            }
        refresh.addTarget(self, action: #selector(refreshData), for:.valueChanged)
    }
    //MARK:- SetUp View
    func setupView() {
        view.addSubview(tableView)
        tableViewSet()
      }
    func tableViewSet()
       {
           tableView.dataSource = self
           tableView.delegate = self
           tableView.estimatedRowHeight = 600
           tableView.rowHeight = UITableView.automaticDimension
           tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier:reuserIdetifer)
           tableView.translatesAutoresizingMaskIntoConstraints = false
           tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
           tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
           tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       }
    }
