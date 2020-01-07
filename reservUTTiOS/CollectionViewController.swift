//
//  CollectionViewController.swift
//  reservUTTiOS
//
//  Created by edifixio on 24/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var db: Firestore!
    
    var reservationArray = [Reservation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()

        loadData()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reservationArray.count
    }

    func collectionView( _ collectionView: UICollectionView, cellForItemAt    indexPath: IndexPath) -> UICollectionViewCell {
        
        let reservation = reservationArray[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell2
        
        cell.salle.text = reservation.salleName
        
        print(reservation.salleName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let reservation = reservationArray[indexPath.row]
        print(reservation.salleName)
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
                self.collectionView.reloadData()
            }
        }
    }

}
