//
//  File.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 28/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import UIKit

class AmiibiCell:UITableViewCell {
    var safeArea:UILayoutGuide!
    var imageIV = CustomImageView()
    var nameLabel = UILabel()
    var nameLabel1 = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -Setup
    func setupView()
    {
        safeArea = layoutMarginsGuide
        setupImageView()
        setupNameLabel()
        setupNameLabel1()
    }
    
    func setupImageView()
    {
        addSubview(imageIV)
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor).isActive = true
        imageIV.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        imageIV.widthAnchor.constraint(equalToConstant:40).isActive = true
        imageIV.heightAnchor.constraint(equalToConstant:40).isActive = true
    }
    func setupNameLabel()
    {
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor,constant: 5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLabel.font = UIFont(name:"Verdana-Bold", size:14)
        nameLabel.numberOfLines = 0
    }
    func setupNameLabel1()
    {
        
        let marginGuide = contentView.layoutMarginsGuide
               contentView.addSubview(nameLabel1)
               nameLabel1.translatesAutoresizingMaskIntoConstraints = false
               nameLabel1.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
               nameLabel1.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
               nameLabel1.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
               nameLabel1.font = UIFont(name:"Verdana", size:14)
               nameLabel1.numberOfLines = 0
    }
}

