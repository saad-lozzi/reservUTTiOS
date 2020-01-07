//
//  TableViewController.swift
//  reservUTTiOS
//
//  Created by edifixio on 20/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet weak var tableview: UITableView!
    
    var items: [String] = []
       
       var identifiantModuleImage = "imageModule"

       override func viewDidLoad() {
           super.viewDidLoad()


           print(Common.USERNAME)
           
       }
       
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }

       // MARK: - Table view data source

       override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 1
       }

       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

           let cell = tableView.dequeueReusableCell(withIdentifier: identifiantModuleImage, for: indexPath)
           
           cell.textLabel?.text = "Cellule \(indexPath.row)"
           
       
           return cell
       }
}
