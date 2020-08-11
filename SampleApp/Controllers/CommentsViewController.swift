//
//  CommentsViewController.swift
//  SampleApp
//
//  Created by Juan Manuel Tome on 11/08/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class CommentsViewController: UITableViewController {
    
    //MARK: - Sections
    enum Sections: Int {
        case Post
        case Comments
    }
    //MARK: - ReuseIdentifiers
    var standardCellReuseIdentifier = "StandardCell"
    var postBodyIdentifier = "bodyCellId"
    
    //MARK: - Properties
    var post: PostViewModel!
    
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavCon()
    }
    
}

//MARK: - UI Setup Methods
extension CommentsViewController {
    //MARK: - Setup NavCon
    func setupNavCon() {
        navigationItem.title = "Post: " + post.post.title
    }
    //MARK: - Setup TV
    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.register(StandardCell.self, forCellReuseIdentifier: standardCellReuseIdentifier)
        tableView.register(ProfileCell.self, forCellReuseIdentifier: postBodyIdentifier)
    }
    
}

//MARK: - Table view data source
extension CommentsViewController {
    //Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //Number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .Post: //user id, post id, title, body
            return 4
        case .Comments:// all of the post comments
            fallthrough
        default:
            return post.comments?.count ?? 0
        }
    }
    //Set titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Sections(rawValue: section) {
        case .Post:
            return "Post"
        case .Comments:
            fallthrough
        default:
            return "Comments"
        }
    }
    
   
    // Create cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section) {
        case .Post:
            let row = indexPath.row
            switch row {
            case 0:// User ID
                let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
                
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.textColor = UIColor(named: "Color1")
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                
                cell.textLabel?.text = "User ID: "
                cell.detailTextLabel?.text = "\(post.post.userId)"
                return cell
            case 1:// Post ID
                let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
                
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.textColor = UIColor(named: "Color1")
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                
                cell.textLabel?.text = "Post ID: "
                cell.detailTextLabel?.text = "\(post.post.id)"
                return cell
            case 2:// Post Title
                let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
                
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.textColor = UIColor(named: "Color1")
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                
                cell.textLabel?.text = "Post Title: "
                cell.detailTextLabel?.text = post.post.title.capitalized
                return cell
            case 3:// Post Body
                fallthrough
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: postBodyIdentifier, for: indexPath) as! ProfileCell
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.textColor = UIColor(named: "Color1")
                cell.detailTextLabel?.numberOfLines = 0
                
                cell.textLabel?.text = "Body: "
                cell.detailTextLabel?.text = post.post.body.capitalized
                return cell
            }
        case .Comments:
            fallthrough
        default: //Cells for comments
            let cell = tableView.dequeueReusableCell(withIdentifier: standardCellReuseIdentifier, for: indexPath) as! StandardCell
            
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
            cell.textLabel?.textColor = UIColor(named: "Color1")
            cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
            
            let comment = post.comments?[indexPath.row]
            
            cell.textLabel?.text = "# \(comment!.id):"
            cell.detailTextLabel?.text = comment?.name.capitalized
            
            return cell
        }
    }
    // Set row height according to section and cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Sections(rawValue: indexPath.section) {
        case .Post:
            let row = indexPath.row
            switch row {
            case 0, 1, 2: // user id, post id,post title
                return 44
            case 3:// body
                fallthrough
            default:
                return 150
            }
        case .Comments:
            fallthrough
        default:
            return 44
        }
    }
}

//MARK: - TableView Delegate
extension CommentsViewController {
    //Actions when a cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = Sections(rawValue: indexPath.section)
        guard section == .some(.Comments) else { return }
        
        let comment = post.comments?[indexPath.row]
        let commentVC = CommentViewController()
        commentVC.comment = comment
        
        navigationController?.pushViewController(commentVC, animated: true)
        
    }
}
