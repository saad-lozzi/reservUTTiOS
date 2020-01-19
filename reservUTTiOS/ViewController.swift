//
//  ViewController.swift
//  reservUTTiOS
//
//  Created by edifixio on 12/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    @IBOutlet weak var signSelector: UISegmentedControl!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailtxtField: UITextField!
    @IBOutlet weak var pwtxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNametxtField: UITextField!
    @IBOutlet weak var professionSegmented: UISegmentedControl!
    
    var db:Firestore!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "main.png")!)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func signSelectorChanged(_ sender: UISegmentedControl)
    {
        isSignIn = !isSignIn
        if(isSignIn)
        {
            loginBtn.setTitle("Se connecter", for: .normal)
            userNameLabel.isHidden = true
            userNametxtField.isHidden = true
            professionSegmented.isHidden = true
        }
        else
        {
            loginBtn.setTitle("S'inscrire", for: .normal)
            userNameLabel.isHidden = false
            userNametxtField.isHidden = false
            professionSegmented.isHidden = false
        }
    }
    
    @IBAction func signIn(_ sender: UIButton)
    {
        let email = emailtxtField.text!
        
        let password = pwtxtField.text!
        
        if(isSignIn)
        {
            //signin code
            Auth.auth().signIn(withEmail: email, password: password)
            {
                user, error in
                
                if let u = user {
                    // User is found go home
                    let db = Firestore.firestore()
                    
                    let docRef = db.collection("User").document(u.user.uid)
                    docRef.getDocument { (document, error) in
                        
                       
                    if let document = document, document.exists {
                            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data: \(document.data()?["username"])")
                            print("Document data: \(document.data()?["profession"])")
                            Common.USERNAME = document.data()!["username"] as! String
                            self.performSegue(withIdentifier: "goToHome", sender: self)
                            //Common.PROFESSION = document.data!["profession"] as! String
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                    
                } else {
                    //show error
                }
            }
        
        }
        else
        {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                if let u = user {
                    //user found go home
                    
                    var ref: DocumentReference? = nil
                    self.db.collection("User").document(u.user.uid).setData([
                        "email": email,
                        "id": u.user.uid,
                        "profession": self.professionSegmented.titleForSegment(at: self.professionSegmented.selectedSegmentIndex),
                        "username": self.userNametxtField.text!
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            Common.USERNAME = self.userNametxtField.text!
                            Common.PROFESSION = self.self.professionSegmented.titleForSegment(at: self.professionSegmented.selectedSegmentIndex)!
                            self.performSegue(withIdentifier: "goToHome", sender: self)
                        }
                    }
                    /*let newUser = User(email:email,
                                       username:self.userNametxtField.text!,
                                       id:u.user.uid,
                                       profession:self.professionSegmented.titleForSegment(at: self.professionSegmented.selectedSegmentIndex)!)
                    
                    var ref:DocumentReference? = nil
                    ref = self.db.collection("User").addDocument(data: newUser.dictionary){
                        err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }*/
                    
                    
                    
                }
                else {
                    //show error
                }
            }
        }

    }
}

