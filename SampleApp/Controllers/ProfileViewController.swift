//
//  ProfileViewController.swift
//  SampleApp
//
//  Created by Juan Manuel Tome on 10/08/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UITableViewController {
    
    //MARK: - Sections
    enum Sections: Int {
        case User
        case Address
        case ContactDetails
        case Company
        case Posts
    }
    
    //MARK: - Reuse Identifiers
    var standardCellReuseIdentifier = "StandardCell"
    var profileReuseIdentifier = "ProfileCell"
    
    //MARK: - Properties
    var userProfile: UserViewModel!
    
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavCon()
    }
 
}
//MARK: - UI Setup Methods
extension ProfileViewController {
    //MARK: - Setup NavCon
    func setupNavCon() {
        navigationItem.title = "User: " + userProfile.user.username
    }
    //MARK: - Setup TV
    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.register(StandardCell.self, forCellReuseIdentifier: standardCellReuseIdentifier)
        tableView.register(ProfileCell.self, forCellReuseIdentifier: profileReuseIdentifier)
    }
}



//MARK: - Table view data source
extension ProfileViewController {
    //Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    //Number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .User://UserName, ID,
            return 2
        case .Address://Address
            return 5
        case .ContactDetails://Phone, Email, Website
            return 3
        case .Company://Company (name, catchphrase, bs)
            return 3
        case .Posts:
            fallthrough
        default:
            return userProfile.posts?.count ?? 0
        }
    }
    //Set titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Sections(rawValue: section) {
        case .User:
            return "User"
        case .Address:
            return "Address"
        case .ContactDetails:
            return "Contact Details"
        case .Company:
            return "Company"
        case .Posts:
            fallthrough
        default:
            return "User Posts"
        }
    }
    // Create cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section) {
        case .User:
            let row = indexPath.row
            switch row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
                cell.imageView?.image = userProfile.userImage
                
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.textColor = UIColor(named: "Color1")
                cell.textLabel?.text = "Name: "
                
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                cell.detailTextLabel?.text = userProfile.user.name
                
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
                
                cell.textLabel?.text = "ID: "
                cell.textLabel?.textColor = UIColor(named: "Color1")
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                cell.detailTextLabel?.text = "\(userProfile.user.id)"
                return cell
            }
        case .Address:
            let row = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
            
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
            cell.textLabel?.textColor = UIColor(named: "Color1")
            cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
            
            switch row {
            case 0:
                cell.textLabel?.text = "City: "
                cell.detailTextLabel?.text = userProfile.user.address.city
            case 1:
                cell.textLabel?.text = "Street: "
                cell.detailTextLabel?.text = userProfile.user.address.street
            case 2:
                cell.textLabel?.text = "Suite: "
                cell.detailTextLabel?.text = userProfile.user.address.suite
            case 3:
                cell.textLabel?.text = "Coordinates: "
                cell.detailTextLabel?.text = "Lat: \(userProfile.user.address.geo.lat), Lon: \(userProfile.user.address.geo.lng)"
            case 4:
                fallthrough
            default:
                cell.textLabel?.text = "Zip: "
                cell.detailTextLabel?.text = userProfile.user.address.zipcode
            }
            return cell
        case .ContactDetails:
            let row = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
            
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
            cell.textLabel?.textColor = UIColor(named: "Color1")
            cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
            
            switch row {
            case 0:
                cell.textLabel?.text = "Email: "
                cell.detailTextLabel?.text = userProfile.user.email.lowercased()
            case 1:
                cell.textLabel?.text = "Phone: "
                cell.detailTextLabel?.text = userProfile.user.phone
            default:
                cell.textLabel?.text = "Website: "
                cell.detailTextLabel?.text = "https://" + userProfile.user.website.lowercased()
            }
            return cell
        case .Company:
            let row = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
            cell.textLabel?.textColor = UIColor(named: "Color1")
            cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
            
            switch row {
            case 0:
                cell.textLabel?.text = "Name: "
                cell.detailTextLabel?.text = userProfile.user.company.name
            case 1:
                cell.textLabel?.text = "Slogan: "
                cell.detailTextLabel?.text = userProfile.user.company.catchPhrase
            default:
                cell.textLabel?.text = "BS: "
                cell.detailTextLabel?.text = userProfile.user.company.bs
            }
            return cell
        case .Posts:
            let cell = tableView.dequeueReusableCell(withIdentifier: profileReuseIdentifier, for: indexPath) as! ProfileCell

            let post = userProfile.posts?[indexPath.row]
            
            cell.textLabel?.text = post?.post.title.capitalized
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
            cell.textLabel?.textColor = UIColor(named: "Color1")
            cell.textLabel?.numberOfLines = 0
//            cell.detailTextLabel?.text = post?.body
            cell.detailTextLabel?.text = "\(post!.comments!.count) comments"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
            return cell
        }
    }
    
    // Set row height according to section and cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        switch Sections(rawValue: indexPath.section) {
        case .User:
            if row == 0 {
                return 100
            }
            fallthrough
        case .Address, .ContactDetails, .Company:
            return 44
        case .Posts:
            fallthrough
        default:
            return 100
        }
    }
}

//MARK: - TableView Delegate
extension ProfileViewController {
    //Actions when a cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = Sections(rawValue: indexPath.section)
        guard section == .some(.Posts) else { return }
        
        let post = userProfile.posts?[indexPath.row]
        print(indexPath.row)
        let commentsViewController = CommentsViewController()
        commentsViewController.post = post
        
        navigationController?.pushViewController(commentsViewController, animated: true)
    }
}
