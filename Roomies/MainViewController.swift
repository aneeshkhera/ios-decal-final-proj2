//
//  MainViewController.swift
//  Roomies
//
//  Created by Sam Steady on 12/6/16.
//  Copyright © 2016 Sam Steady. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func sendSegue(_ sender: UIButton) {

        sendingUser = users[sender.tag].name
        performSegue(withIdentifier: "showChores", sender: nil)
    }
    
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    
    var sendingUser: String!
    
    var users:[User] = []
    
    let userColor = UIColor(red: 129/255, green: 211/255, blue: 207/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.separatorStyle = .none
        loadData()

    }
    
    
    
    func loadData() {
        if let loadedData = UserDefaults().data(forKey: "userData") {
            if let loadedUsers = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as? [User] {
                users = loadedUsers
            }
        }
        
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func addUser() {
        performSegue(withIdentifier: "addUser", sender: self)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        var usersChores: [Chore] = []
        let curUser = users[indexPath.row]
        
        if let loadedData = UserDefaults().data(forKey: curUser.name) {
            if let loadedChores = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as? [Chore] {
                usersChores = loadedChores
            }
        }
        
        let numChoresString = "(" + String(usersChores.count) + ")"
        
        cell.textLabel?.text = curUser.name
        cell.cellButton.backgroundColor = userColor
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-bold", size: 20.0)
        cell.restoreButton.backgroundColor = UIColor.clear
        cell.restoreButton.setTitle(numChoresString, for: .normal)
        
        
        cell.textLabel?.textAlignment = .center
        cell.cellButton.layer.cornerRadius = 5
        cell.cellButton.tag = indexPath.row
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.clear
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userData = NSKeyedArchiver.archivedData(withRootObject: users)
        UserDefaults.standard.set(userData, forKey: "userData")
        if segue.identifier == "showChores" {
            let child = segue.destination as! PersonViewController
            child.name = self.sendingUser
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        table.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
