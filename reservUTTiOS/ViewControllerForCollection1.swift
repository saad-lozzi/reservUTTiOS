//
//  ViewControllerForCollection1.swift
//  reservUTTiOS
//
//  Created by edifixio on 24/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewControllerForCollection1: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var db: Firestore!
    
    var reservationArray = [Reservation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()

        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        
        let userID = Auth.auth().currentUser!.uid
        
        print("result **************")
        
        db.collection("User").document(userID).collection("Booking").getDocuments(){
            snapShot , error in
             
            if let error = error {
                print ("result /////////////\(error.localizedDescription)")
            }else{
                print(snapShot?.count)
                let snap = snapShot?.documents
                snap!.forEach{
                    element in
                    let el = element.data()
                    
                    if el == nil {
                        print("null element")
                    } else {
                        print("affecting element")
                        self.reservationArray.append(Reservation(dictionary: el)!)
                    }
                }
                self.tableV.reloadData()
            }
            
            
            
        }
    }
}
