//
//  FirstViewController.swift
//  MoveIt
//
//  Created by Lawrence Chen on 1/13/17.
//  Copyright © 2017 Lawrence Chen. All rights reserved.
//

import UIKit



class FirstViewController: UIViewController{

    @IBOutlet var profilepicture: UIImageView!
    @IBOutlet var emaillabel: UILabel!
    @IBOutlet var genderlabel: UILabel!
    @IBOutlet var label: UILabel!
    var name:String = ""
    var gender:String = ""
    var email:String = ""
    var url:String = ""
    
    override func viewDidLoad() {
        
        print (name)
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.name = appDelegate.name
        label.text = self.name
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print (name)
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.name = appDelegate.name
        self.gender = appDelegate.gender
        self.email = appDelegate.email
        self.url = appDelegate.url
        label.text = self.name
        genderlabel.text = self.gender
        emaillabel.text = self.email
        let url = NSURL(string: self.url)
        let data = NSData(contentsOf : url as! URL)
        if(data != nil){
            let image = UIImage(data : data as! Data)
            self.profilepicture.image = image
        }
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

