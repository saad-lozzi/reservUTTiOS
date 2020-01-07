//
//  ViewControllerForPickVal.swift
//  reservUTTiOS
//
//  Created by edifixio on 23/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewControllerForPickVal: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    
    let batiments = ["A","B","C","E","F","M","N","X"]
    
    var salles = [String]()
    
    var sallesId = [String]()
    
    var db: Firestore!
    
    var reservationArray = [Reservation]()
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return batiments[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return batiments.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Common.BATIMENT = batiments[row]
        print(Common.BATIMENT)
        self.salles.removeAll()
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()

        loadData()
        

        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        
        let userID = Auth.auth().currentUser!.uid
        
        print("result **************")
        
        db.collection("Salles").document(Common.BATIMENT).collection("salle").getDocuments(){
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
                        self.salles.append(element.data()["name"] as! String)
                        
                        self.sallesId.append(element.documentID as! String)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
}


extension ViewControllerForPickVal : UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return salles.count
    }

        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let salle = salles[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath) as! TableViewCell2
            
        //cell.textLabel?.text = "Nom de l'utilisateur : \(reservation.user)"
        
        print(salle)
        
        //cell.detailTextLabel?.text = "Salle : \(reservation.salleName)"
        
        cell.salleName.text = salle
        
                
        //cell.textLabel?.text = "element "
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.nextBtn.isEnabled = true
        Common.SALLE = salles[indexPath.row]
        print(Common.SALLE)
        Common.SALLEID = sallesId[indexPath.row]
        print(Common.SALLEID)
    }
}
