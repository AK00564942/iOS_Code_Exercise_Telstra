//
//  File.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 28/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsTableViewCell:UITableViewCell {
    
    let detailImg:UIImageView = {
        let detailImg = UIImageView()
        // image will never be strecthed vertially or horizontally
        detailImg.contentMode = .scaleAspectFill
        // enable autolayout
        detailImg.translatesAutoresizingMaskIntoConstraints = false
        detailImg.clipsToBounds = true
        return detailImg
    }()
    
    let detailsTitle:UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    let detailsDesc:UILabel = {
        let descLabel = UILabel()
        descLabel.font = UIFont.boldSystemFont(ofSize: 12)
        descLabel.textColor =  UIColor.black
        descLabel.layer.cornerRadius = 5
        descLabel.clipsToBounds = true
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        return descLabel
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(detailImg)
        containerView.addSubview(detailsTitle)
        containerView.addSubview(detailsDesc)
        self.contentView.addSubview(containerView)
        
        self.preservesSuperviewLayoutMargins = true
        self.contentView.preservesSuperviewLayoutMargins = true
        
        detailImg.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        detailImg.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        detailImg.widthAnchor.constraint(equalToConstant:70).isActive = true
        detailImg.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.detailImg.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalTo:self.contentView.heightAnchor, constant:-20).isActive = true
        
        detailsTitle.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        detailsTitle.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        detailsTitle.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        detailsDesc.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        detailsDesc.topAnchor.constraint(equalTo:self.detailsTitle.bottomAnchor).isActive = true
        detailsDesc.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        let containerViewHeightConstant = containerView.heightAnchor.constraint(equalToConstant: 1)
        containerViewHeightConstant.priority = UILayoutPriority.init(999)
        containerViewHeightConstant.isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(detailViewData:Rows)
    {
        detailImg.image = nil
        detailsTitle.text = detailViewData.title
        detailsDesc.text = detailViewData.description
        if let imagePath = detailViewData.imageHref
        {
            //Lazy Loading Implementation
            detailImg.sd_setImage(with: URL(string:imagePath), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}

