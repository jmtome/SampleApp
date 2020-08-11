//
//  CommentViewController.swift
//  SampleApp
//
//  Created by Juan Manuel Tome on 11/08/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class CommentViewController: UITableViewController {
    
    //MARK: - Sections
    enum Sections: Int {
        case Details
        case Body
    }
    
    //MARK: - ReuseIdentifiers
    var standardCellReuseIdentifier = "StandardCell"
    var postBodyIdentifier = "bodyCellId"
    //MARK: - Properties
    var comment: Comment!
    
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavCon()
    }
}


//MARK: - UI Setup Methods
extension CommentViewController {
    //MARK: - Setup NavCon
    func setupNavCon() {
        navigationItem.title = "Comment: \(comment.id)" 
    }
    //MARK: - Setup TV
    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.register(StandardCell.self, forCellReuseIdentifier: standardCellReuseIdentifier)
        tableView.register(ProfileCell.self, forCellReuseIdentifier: postBodyIdentifier)
    }
}



// MARK: - Table view data source
extension CommentViewController {
    
    //Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //Number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .Details:
            return 4
        case .Body:
            fallthrough
        default:
            return 1
        }
    }
    // Create cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section) {
        case .Details:
            let row = indexPath.row
            switch row {
            case 0:// Post id
                let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
                
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.textColor = UIColor(named: "Color1")
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                
                cell.textLabel?.text = "Post Id: "
                cell.detailTextLabel?.text = "\(comment.postId)"
                return cell
            case 1:// Comment id
                let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
                
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.textColor = UIColor(named: "Color1")
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                
                cell.textLabel?.text = "Comment Id: "
                cell.detailTextLabel?.text = "\(comment.id)"
                return cell
            case 2:// Commenter name
                let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
                
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.textColor = UIColor(named: "Color1")
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                
                cell.textLabel?.text = "Title: "
                cell.detailTextLabel?.text = comment.name.capitalized
                return cell
            case 3:// Commenter email
                fallthrough
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
                
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.textColor = UIColor(named: "Color1")
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                
                cell.textLabel?.text = "Commenter: "
                cell.detailTextLabel?.text = comment.email.lowercased()
                return cell
            }
        case .Body:
            fallthrough
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: postBodyIdentifier, for: indexPath) as! ProfileCell
            
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
            cell.textLabel?.textColor = UIColor(named: "Color1")
            cell.detailTextLabel?.numberOfLines = 0
            
            cell.textLabel?.text = "Comment Body: "
            cell.detailTextLabel?.text = comment.body.capitalized
            return cell
        }
    }
    // Set row height according to section and cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Sections(rawValue: indexPath.section) {
        case .Details:
            return 44
        case .Body:
            fallthrough
        default:
            return 150
        }
    }
}

//MARK: - TableView Delegate
extension CommentViewController {
    //Actions when a cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
