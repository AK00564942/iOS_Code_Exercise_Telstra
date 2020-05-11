//
//  DetailsViewController.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 27/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController{
   
    var viewModel : DetailsViewModel!
    private var refreshControl = UIRefreshControl()
    
    let indicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:60, height:60))
        indicator.style = .gray
        return indicator
       }()
    
    let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
     
    init(viewModel: DetailsViewModel)
    {
      super.init(nibName: nil, bundle: nil)
      self.viewModel = viewModel
      self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder)
    {
       fatalError("init(coder:) has not been implemented")
    }
    
     override func viewDidLoad()
      {
        setupView()
      }
     @objc func refreshData(sender:UIRefreshControl)
     {
        sender.endRefreshing()
      }
    //MARK:- SetUp View
    func setupView()
     {
        view.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(DetailsViewController.refresh(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        setupLayout()
        setLayoutConstraints()
        // Load content
        self.viewModel.getDataFromServer()
     }
    
    @objc func refresh(sender:AnyObject)
    {
        self.viewModel.getDataFromServer()
    }   
    
    func setupLayout(){
        tableView.frame = view.bounds
        view.addSubview(tableView)

        indicator.center = self.tableView.center
        self.view.addSubview(indicator)
    }
    
    func setLayoutConstraints()
     {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
     }
   }

extension DetailsViewController:UITableViewDelegate, UITableViewDataSource {
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return viewModel.items.count
            }
            
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100.0
        }
            
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
            
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? DetailsTableViewCell
            let item = viewModel.items[indexPath.row]
            cell?.configure(detailViewData:item)
            return cell!
        }
}

extension DetailsViewController: DetailsViewModelDelegate {
        func serverDataUpdated() {
            DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.navigationItem.title = self?.viewModel.title
            self?.indicator.stopAnimating()
            self?.indicator.hidesWhenStopped = true
            self?.refreshControl.endRefreshing()
          }
      }
   }
