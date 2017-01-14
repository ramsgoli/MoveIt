//
//  FirstViewController.swift
//  MoveIt
//
//  Created by Lawrence Chen on 1/13/17.
//  Copyright © 2017 Lawrence Chen. All rights reserved.
//

import UIKit



class FirstViewController: UIViewController{

    @IBOutlet var label: UILabel!
    var name:String = "Hey"
    
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
        label.text = self.name
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

