//
//  InfoViewController.swift
//  MoveIt
//
//  Created by Lawrence Chen on 1/15/17.
//  Copyright © 2017 Lawrence Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class InfoViewController: UIViewController {

    @IBOutlet var protestLabel: UILabel!
    
    @IBOutlet var attendingLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var hostLabel: UILabel!
    var idString = ""
    
    var json: [String:AnyObject] = ["":"" as AnyObject]
    var protestArray: [NSDictionary] = [["":""]]
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
        /*
        ref.child("protests").child(idString).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let protest = value?["protestname"] as? String ?? ""
            self.protestLabel.text = protest
            let host = value?["hostname"] as? String ?? ""
            self.hostLabel.text = "By: \(host)"
            let location = value?["location"] as? String ?? ""
            self.locationLabel.text = "At \(location)"
            let date = value?["date"] as? String ?? ""
            self.dateLabel.text = date
            let attending = value?["attending"] as? Int ?? 0
            self.dateLabel.text = "\(attending)"
 
        }) { (error) in
            print(error.localizedDescription)
        }*/
        print(idString)
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
