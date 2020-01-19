//
//  ConfirmViewController.swift
//  reservUTTiOS
//
//  Created by edifixio on 10/01/2020.
//  Copyright © 2020 edifixio. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ConfirmViewController: UIViewController {
    
    @IBOutlet weak var salleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var heureLabel: UILabel!
    
    var db: Firestore!

    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        db = Firestore.firestore()
        
        salleLabel.text = Common.SALLE
        dateLabel.text = Common.DATETIME
        

        // Do any additional setup after loading the view.
    }
    @IBAction func confirmClick(_ sender: UIButton) {
        
        let userID = Auth.auth().currentUser!.uid
        
        let slot = "\(Common.SLOT)"
                
        print(Common.BATIMENT)
        print(Common.SALLEID)
        print(Common.DATE)
        print(slot)
        print(userID)
        let time = Timestamp.init(date: NSDate.now)
        
        let docData: [String: Any] = [
            "done" : false,
            "salleId" : Common.SALLEID,
            "salleName" : Common.SALLE,
            "slot": Common.SLOT,
            "time": Common.DATETIME,
            "timestamp": time,
            "user": Common.USERNAME,
            "userId": userID
        ]
        self.db.collection("User").document(userID).collection("Booking").document(Common.SALLEID).setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        self.db.collection("Salles").document(Common.BATIMENT).collection("salle").document(Common.SALLEID).collection(Common.DATE).document(slot).setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
