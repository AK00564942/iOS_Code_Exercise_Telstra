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
    var titlelbl = UILabel()
    var desclbl = UILabel()
    
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
        setupTitlelbl()
        setupDesclbl()
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
    func setupTitlelbl()
    {
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(titlelbl)
        titlelbl.translatesAutoresizingMaskIntoConstraints = false
        titlelbl.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor,constant: 5).isActive = true
        titlelbl.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titlelbl.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titlelbl.font = UIFont(name:"Verdana-Bold", size:14)
        titlelbl.numberOfLines = 0
    }
    func setupDesclbl()
    {
        
        let marginGuide = contentView.layoutMarginsGuide
               contentView.addSubview(desclbl)
               desclbl.translatesAutoresizingMaskIntoConstraints = false
               desclbl.leadingAnchor.constraint(equalTo: titlelbl.leadingAnchor).isActive = true
               desclbl.topAnchor.constraint(equalTo: titlelbl.bottomAnchor).isActive = true
               desclbl.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
               desclbl.font = UIFont(name:"Verdana", size:14)
               desclbl.numberOfLines = 0
    }
}

