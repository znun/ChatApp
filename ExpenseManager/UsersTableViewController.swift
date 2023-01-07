//
//  UsersTableViewController.swift
//  ChatApp
//
//  Created by Xunnun on 25/3/22.
//

import UIKit

class UsersTableViewController: UITableViewController {

    //MARK: - Vars
    var allUsers: [User] = []
    var filteredUsers: [User] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

       // createDummyUsers()
        
        downloadUsers()
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchController.isActive ? filteredUsers.count : allUsers.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell
        let user = searchController.isActive ? filteredUsers[indexPath.row] : allUsers[indexPath.row]
        cell.configure(user: user)
        return cell
    }

   //MARK: - DownloadUsers
    private func downloadUsers() {
        FirebaseUserListener.shared.downloadAllUsersFromFirebase { (allFirebaseUsers) in
            self.allUsers = allFirebaseUsers
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
