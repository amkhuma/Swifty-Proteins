//
//  LigandModelViewController.swift
//  Swifty Proteins
//  let HttpResponse = response as? HTTPURLResponse
//  HttpResponse?.statusCode)! >= 200 && (HttpResponse?.statusCode)! <= 299
//  Created by Andile MKHUMA on 2018/10/22.
//  Copyright © 2018 Andile MKHUMA. All rights reserved.
//

import UIKit

class LigandModelViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var ligandName : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(self.ligandName)"
        self.getLigandData(ligandName: self.ligandName, with: { (data) -> (Void) in
            self.extractData(data: data)
        }, with: { (error) -> (Void) in
            print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLigandData(ligandName : String, with success : @escaping (Data) -> (Void), with erroring : @escaping (Error) -> (Void))
    {
        let url = URL(string: "https://files.rcsb.org/ligands/view/\(ligandName)_ideal.pdb")
        let request = NSMutableURLRequest(url: url!)
        activityIndicator.startAnimating()
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            if let err = error{
                erroring(err)
            }
            else if (data != nil){
                success(data!)
            }
        }
        task.resume()
        activityIndicator.stopAnimating()
    }
    
    func extractData(data : Data)
    {
        print("doing it ")
        let decodedString = String(data: data, encoding: .utf8)!
        print(decodedString)
    }
}
