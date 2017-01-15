//
//  ThirdViewController.swift
//  MoveIt
//
//  Created by Lawrence Chen on 1/13/17.
//  Copyright © 2017 Lawrence Chen. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FacebookCore
import FirebaseDatabase



class ThirdViewController: UIViewController, FBSDKLoginButtonDelegate  {

    var name:String = ""
    var gender:String = ""
    var email:String = ""
    var url:String = ""
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        loginButton.center = view.center
        
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        loginButton.delegate = self
        

    }

    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = FIRAuth.auth()
        do{
            try firebaseAuth?.signOut()
        }catch let signOutError as NSError{
            print("Error signing outL %@", signOutError)
        }
        
        print("Did log out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        
        if error != nil{
            print(error)
            return
        }
        else if result.isCancelled{
            
        }
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if error != nil{
                return
            }
        }
        
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name,gender,picture"], tokenString: FBSDKAccessToken.current().tokenString, version: nil, httpMethod: "GET")
        req!.start{response, result, error in
            if(error == nil)
            {
                print("result \(result)")
                let json = result as! [String: AnyObject]
                print (json["name"] as! String)
                self.name = json["name"] as! String
                self.gender = json["gender"] as!String
                self.email = json["email"] as!String
                let picture = json["picture"] as! [String:AnyObject]
                let picturedata = picture["data"] as! [String:AnyObject]
                self.url = picturedata["url"] as! String
 
               
                print(self.url)
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

                appDelegate.name = self.name
                appDelegate.gender = self.gender
                appDelegate.email = self.email
                appDelegate.url = self.url
                
                if FIRAuth.auth()?.currentUser != nil {
                    let user = FIRAuth.auth()?.currentUser
                    self.ref = FIRDatabase.database().reference()
                    self.ref.child("users").child((user?.uid)!).setValue(["name": self.name, "gender": self.gender, "email": self.email, "ProfilePicURL": self.url, "protestcount": "0"])
                } else {
                    // No user is signed in.
                    // ...
                }
                
                
            
            }
            else
            {
                print("error \(error)")
            }
        }
        
        
        print("Successfully logged in with Facebook")
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
