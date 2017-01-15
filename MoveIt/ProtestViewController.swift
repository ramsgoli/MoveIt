//
//  ProtestViewController.swift
//  
//
//  Created by Lawrence Chen on 1/14/17.
//
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import CoreLocation

import Foundation

struct ProtestItem {
    let ref: FIRDatabaseReference?
    
    let hostname: String
    let protestname: String
    let location: String
    let description: String
    let date: String
    let attending: Int
    let latitude: Double
    let longitude: Double
    
    init(hostname: String, protestname: String, location:String, description: String, date:String, coordinates: CLLocation, attending:Int) {
        self.hostname = hostname
        self.protestname = protestname
        self.location = location
        self.description = description
        self.date = date
        self.latitude = coordinates.coordinate.latitude
        self.longitude = coordinates.coordinate.longitude
        self.attending = attending
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        hostname = snapshotValue["hostname"] as! String
        protestname = snapshotValue["protestname"] as! String
        location = snapshotValue["location"] as! String
        description = snapshotValue["description"] as! String
        date = snapshotValue["date"] as! String
        latitude = snapshotValue["latitude"] as! Double
        longitude = snapshotValue["longitude"] as! Double
        attending = snapshotValue["attending"] as! Int
        

        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "hostname": hostname,
            "protestname": protestname,
            "location": location,
            "description": description,
            "date" : date,
            "latitude": latitude,
            "longitude":longitude,
            "attending" : attending
        ]
    }
    
}


class ProtestViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var protestLocation: UITextField!
    @IBOutlet var protestDescription: UITextField!
    @IBOutlet var protestName: UITextField!
    @IBOutlet var host: UITextField!
    var strDate = ""
    var ref : FIRDatabaseReference!
    var locationManager: CLLocationManager!
    var userLocation: CLLocation? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        locationManager = CLLocationManager()
        
        locationManager.requestAlwaysAuthorization()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            print("YAYAYAYAYYA")
        }else{
            print("OMGOMGOMGOMGOMG HELP")
        }

        let date:Date = datePicker.date
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
        strDate = formatter.string(from: date)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createButton(_: UIButton) {
        print(strDate)
        print(host.text!)
        if FIRAuth.auth()?.currentUser != nil {
            let ref = FIRDatabase.database().reference(withPath: "protests")
            
            
            if (userLocation != nil){
            let randomkey = randomStringWithLength(len: 10) as String
            let protest = ref.child(randomkey)
            let protestItem = ProtestItem(hostname: host.text!, protestname: protestName.text!, location: protestLocation.text!, description: protestDescription.text!, date: strDate, coordinates: userLocation!, attending: 1)
            protest.setValue(protestItem.toAnyObject())
            }
        } else {
            // No user is signed in.
            // ...
        }
    }
 
   
    @IBAction func dateChanged(_ sender: Any) {
        let date:Date = datePicker.date
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
        strDate = formatter.string(from: date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        host.resignFirstResponder()
        protestName.resignFirstResponder()
        protestLocation.resignFirstResponder()
        protestDescription.resignFirstResponder()
        return false
    }
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0..<len{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        print(userLocation!)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
        }
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
