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

let reuserIdetifer = "cellid"

class DetailsViewController: UIViewController{
     let tableView = UITableView()
     var safeArea: UILayoutGuide!
     var arrDetailsModel = [DetailsViewModel]()
    override func viewDidLoad()
    {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refresh
        }
        else
        {
            tableView.addSubview(refresh)
        }
        refresh.addTarget(self, action: #selector(refreshData), for:.valueChanged)
       navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
       view.backgroundColor = .white
       safeArea = view.layoutMarginsGuide
       setupView()
       fetchDataFromServer()
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
    //MARK:- SetUp View
    func setupView() {
        view.addSubview(tableView)
        tableViewSet()
      }
    func tableViewSet()
       {
           tableView.dataSource = self
           tableView.delegate = self
           tableView.estimatedRowHeight = 200
           //tableView.rowHeight = UITableView.automaticDimension
           tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier:reuserIdetifer)
           tableView.translatesAutoresizingMaskIntoConstraints = false
           tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
           tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
           tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       }
    }
//MARK:- UITableViewDataSource
extension DetailsViewController: UITableViewDataSource,UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:reuserIdetifer, for: indexPath)
    cell.textLabel?.text = arrDetailsModel[indexPath.section].description
    cell.textLabel?.lineBreakMode = .byWordWrapping
    cell.textLabel?.numberOfLines = 0
    cell.sizeToFit()
    
    if let imageUrl = arrDetailsModel[indexPath.section].imageHref
    {
       if let url =  URL(string:imageUrl)
         {
        /** call this method for image lazy loading */
            cell.imageView?.sd_setImage(with: url, placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
     }
    }

    //if arrDetailsModel[indexPath.section].i
    
    return cell
}
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrDetailsModel[section].title
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrDetailsModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descrptionLabel = UILabel(frame:CGRect(x:8,y:60,width:200,height:30))
        descrptionLabel.font = .systemFont(ofSize:12.0)
        descrptionLabel.lineBreakMode = .byWordWrapping
        descrptionLabel.numberOfLines = 0
        descrptionLabel.text = arrDetailsModel[indexPath.section].description
        descrptionLabel.sizeToFit()
        
        var imageHeight = CGFloat(0.0)
        
        
        return descrptionLabel.bounds.height + 6
    }
}


