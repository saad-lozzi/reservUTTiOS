//
//  MyViewController.swift
//  reservUTTiOS
//
//  Created by edifixio on 20/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class MyViewController: UIViewController {
    @IBOutlet weak var tableV: UITableView!
    
    var db: Firestore!
    
    var reservationArray = [Reservation]()
    
    var identifiantModuleImage = "imageModule"
    
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
    
extension MyViewController : UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableV: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return reservationArray.count
    }

        
    func tableView(_ tableV: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reservation = reservationArray[indexPath.row]
        
        let cell = tableV.dequeueReusableCell(withIdentifier: "imageModule", for: indexPath) as! TableViewCell
            
        //cell.textLabel?.text = "Nom de l'utilisateur : \(reservation.user)"
        
        print(reservation.time)
        
        //cell.detailTextLabel?.text = "Salle : \(reservation.salleName)"
        
        cell.nameLabel.text = reservation.user
        
        cell.salleLabel.text = reservation.salleName
        
        cell.timeLabel.text = reservation.time
                
        //cell.textLabel?.text = "element "
        

        
        return cell
    }
}


