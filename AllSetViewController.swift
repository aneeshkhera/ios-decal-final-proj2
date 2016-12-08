//
//  AllSetViewController.swift
//  Roomies
//
//  Created by Sam Steady on 12/6/16.
//  Copyright © 2016 Sam Steady. All rights reserved.
//

import UIKit

class AllSetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
        
            self.performSegue(withIdentifier: "allSet", sender: nil)
        }

        // Do any additional setup after loading the view.
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
