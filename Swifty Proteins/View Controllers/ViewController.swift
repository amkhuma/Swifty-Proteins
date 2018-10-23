//
//  ViewController.swift
//  Swifty Proteins
//
//  Created by Andile MKHUMA on 2018/10/22.
//  Copyright © 2018 Andile MKHUMA. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    var ListOfLigands : [String] = []
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBAction func Login(_ sender: UIButton) {
        let context: LAContext = LAContext()
        
        print("called login")
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        {
            print("good phone")
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "TouchID is required to authenticate Swifty Proteins")
            {
                (wasSuccessful, error) in
                if wasSuccessful
                {
                    print("Right Finger")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "GoToListView", sender: self)
                    }
                }
                else
                {
                    print("Wrong Finger!")
                }
            }
        }
        else
        {
            print("bad phone")
            self.LoginButton.isHidden = true
        }
    }
    
    func getLigands( with success : @escaping (Data) -> (Void), with erroring : @escaping (Error) -> (Void))
    {
        let url = URL(string:"https://projects.intra.42.fr/uploads/document/document/312/ligands.txt")!
        let task = URLSession.shared.dataTask(with:url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    erroring(error!)
                }
            }
            else {
                DispatchQueue.main.async {
                    success(data!)
                }
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToListView" {
            if let nextViewController = segue.destination as? ProteinListViewController {
                    nextViewController.ListOfLigands = self.ListOfLigands
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLigands(with: { (data) -> (Void) in
            if let ligand = String(data: data, encoding: .utf8) {
                for i in ligand.split(separator: "\n") {
                    self.ListOfLigands.append(String(i))
                }
                //print(self.ListOfLigands)
            }
        }, with: { (error) -> (Void) in
            print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

