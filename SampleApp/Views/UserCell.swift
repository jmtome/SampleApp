//
//  UserCell.swift
//  SampleApp
//
//  Created by Juan Manuel Tome on 10/08/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    
    //MARK: Properties
    var userProfile: UserViewModel! {
        didSet {
            userNameLabel.text = userProfile.user.username
            userLabel.text = userProfile.user.name
            userImageView.image = userProfile.userImage
        }
    }
    //MARK: - UI Code
    private let userNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "Color2")
        lbl.font = UIFont.preferredFont(forTextStyle: .subheadline)
        lbl.textAlignment = .left
        lbl.text = "usernameLabel"
        return lbl
    }()
    private let userLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "Color1")
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.text = "userLabel"
        return lbl
    }()
    private let userImageView : UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "star.fill"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor).isActive = true
        return imgView
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.contentMode = .scaleToFill
        stackView.tintColor = UIColor(named: "Color2")
        return stackView
    }()
    
    //MARK: - Cell Life Cycle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(userLabel)
        
        addSubview(stackView)
        addSubview(userImageView)
        
        userImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        userImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
        accessoryType = .disclosureIndicator
        backgroundColor = .secondarySystemGroupedBackground
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

