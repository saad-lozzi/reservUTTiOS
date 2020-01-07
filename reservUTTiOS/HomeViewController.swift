//
//  HomeViewController.swift
//  reservUTTiOS
//
//  Created by edifixio on 13/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var tabBarHome: UITabBarItem!
    @IBOutlet weak var tabBarMesRes: UITabBarItem!
    @IBOutlet weak var tabBarRes: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    var posts = NSMutableArray()
    var db:Firestore!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        homeLabel.text = Common.USERNAME
        
        
        
        print(Common.USERNAME)
        // Do any additional setup after loading the view.
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
