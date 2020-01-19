//
//  TimeViewController.swift
//  reservUTTiOS
//
//  Created by edifixio on 25/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class TimeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var db: Firestore!
    
    var reservedSlot = [Int]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        db = Firestore.firestore()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd_MM_yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        
        //l
        
        //dateLabel.text = dateString
        
        Common.DATE = dateString
        
        //Common.DATETIME = dateString2+" à "+Common.TIME
        
        print(Common.DATE)
        
        print(Common.DATETIME)
        
        loadData()
    }
    
    @IBAction func onChange(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd_MM_yyyy"
        let dateString = dateFormatter.string(from: sender.date)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd/MM/yyyy"
        let dateString2 = dateFormatter2.string(from: sender.date)
        
        //dateLabel.text = dateString
        
        Common.DATETIME = dateString2+" à "+Common.TIME
        
        Common.DATE = dateString
        
        print(Common.DATE)
    
        print(Common.DATETIME)
        
        loadData()
        
        self.reservedSlot = []
        
        self.tableView.reloadData()
    
    }
    
    
    func loadData(){
        
        let userID = Auth.auth().currentUser!.uid
        
        print("result **************")
        db.collection("Salles").document(Common.BATIMENT).collection("salle").document(Common.SALLEID).collection(Common.DATE).getDocuments(){
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
                        print("slot est",  el["slot"])
                        self.reservedSlot.append(el["slot"] as! Int)
                        print("slots are ", self.reservedSlot)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func tableView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        Common.SLOT = indexPath.row
        Common.TIME = Common.convertTimeSlotToString(slot: indexPath.row)
        print(Common.SLOT)
        print(Common.TIME)
        nextButton.isEnabled = true
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd/MM/yyyy"
        let dateString2 = dateFormatter2.string(from: datePicker.date)
        
        Common.DATETIME = dateString2+" à "+Common.TIME
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (!(self.reservedSlot.contains(indexPath.row)))
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TableViewCell3
            
            cell.timeLabel.text = Common.convertTimeSlotToString(slot: indexPath.row)
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TableViewCell3
            
            cell.timeLabel.text = Common.convertTimeSlotToString(slot: indexPath.row)
            cell.isHidden = true
            
            return cell
        }
    }
    
}
