//
//  NewChoreViewController.swift
//  Roomies
//
//  Created by Sam Steady on 12/6/16.
//  Copyright © 2016 Sam Steady. All rights reserved.
//

import UIKit

class NewChoreViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, SSRadioButtonControllerDelegate {
    @IBOutlet weak var difficultySlider: UISlider!
    
    @IBOutlet weak var oneWeek: UIButton!
    @IBOutlet weak var twoWeeks: UIButton!
    @IBOutlet weak var oneMonth: UIButton!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var users:[User]!

    
    var radioButtonController: SSRadioButtonsController?

    override func viewDidLoad() {
        super.viewDidLoad()
        radioButtonController = SSRadioButtonsController(buttons: oneWeek, twoWeeks, oneMonth)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.cornerRadius = 5
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewChoreViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        descriptionTextView.text = "Add a description..."
        descriptionTextView.textColor = UIColor.lightGray
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveChore(_ sender: AnyObject) {
        if(nameTextField.text! == "") {
            let alert = UIAlertController(title: "Empty name field", message: "Please provide name for the chore", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if let loadedData = UserDefaults().data(forKey: "userData") {
            if let loadedUsers = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as? [User] {
                users = loadedUsers
            }
        }
        
        let minUser = getMinUser()
        
        var chores:[Chore]!
        
        if let loadedData = UserDefaults().data(forKey: minUser.name) {
            if let loadedChores = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as? [Chore] {
                chores = loadedChores
            }
        }
        
        let choreName = nameTextField.text!
        var choreDescription = descriptionTextView.text!
        if choreDescription == "Add a description..." {
            choreDescription = ""
        }
        let choreDifficulty = Int(10*difficultySlider.value)
        
        minUser.score = String(choreDifficulty+Int(minUser.score)!)
        
        let choreDifficultyString = String(choreDifficulty)

        let choreFrequency = (radioButtonController?.selectedButton()?.titleLabel?.text!)
        var choreFrequencyUnwrapped = ""
        
        if(choreFrequency == nil) {
            let alert = UIAlertController(title: "No frequency", message: "Please select estimated frequency of chore", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        } else {
            choreFrequencyUnwrapped = choreFrequency! as String!
        }
        
        let calendar = self.childViewControllers[0] as! CalendarViewController
        let choreDate = calendar.calendarView.date
        
        let newChore = Chore(withName: choreName, withDescription: choreDescription, withDifficulty: choreDifficultyString, withFrequency: choreFrequencyUnwrapped, withDate: choreDate)
        
        chores.append(newChore)
        
        
        
        
        let choreData = NSKeyedArchiver.archivedData(withRootObject: chores)
        UserDefaults.standard.set(choreData, forKey: minUser.name)
        let userData = NSKeyedArchiver.archivedData(withRootObject: users)
        UserDefaults.standard.set(userData , forKey: "userData")
        nameTextField.text = ""
        _ = navigationController?.popViewController(animated: true)
    }
    
    func getMinUser() -> User {
        var minScore = Int(users[0].score)
        var minUser = users[0]
        
        for i in 1..<self.users.count {
            print(minScore)
            let user = users[i]
            if Int(user.score)! < minScore! {
                minScore = Int(user.score)
                minUser = user
            }
        }
        
        return minUser

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n") {
            dismissKeyboard()
            return false
        } else {
            return true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "add a description..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
