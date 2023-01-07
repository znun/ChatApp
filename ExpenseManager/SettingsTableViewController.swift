//
//  SettingsTableViewController.swift
//  ChatApp
//
//  Created by Xunnun on 15/3/22.
//

import UIKit
//import RealmSwift
//import SwiftUI

class SettingsTableViewController: UITableViewController {

    let spacing = 20
    
    //MARK:- IBOutlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var appVersionLabel: UILabel!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        showUserInfo()
        
    }
    
    //Mark: - TableView Delegates
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "tableviewBackgroundColor")
            
            //tableView.sectionHeaderHeight = 0.00
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 0.00
//        } else {
//            return CGFloat(spacing / 2)
//        }
        
        //return section == 0 ? 0.0 : 10.0
        
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            performSegue(withIdentifier: "settingsToEditProfileSeg", sender: self)
        
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func tellFriendButtonPressed(_ sender: Any) {
        print("Tell a Friend")
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: Any) {
        print("Show Terms and Conditions")
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        
        FirebaseUserListener.shared.logOutCurrentUser { (error) in
            if error == nil {
                let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginView")
                
                DispatchQueue.main.async {
                    loginView.modalPresentationStyle = .fullScreen
                    self.present(loginView, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func showUserInfo() {
        if let user = User.currentUser {
            usernameLabel.text = user.username
            statusLabel.text = user.status
            appVersionLabel.text = "App version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")"
            if user.avatarLink != "" {
            
                //download and set avatar image
                FileStorage.downloadImage(imageUrl: user.avatarLink) { (avatarImage) in
                    self.avatarView.image = avatarImage
                }
            }
        }
    }
}
