//
//  ProfileViewController.swift
//  obrero_final
//
//  Created by boubakerjouini on 18/6/2021.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var prenomLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomLabel.text = UserDefaults.standard.object(forKey: "lastname") as? String;
      
//        nomLabel.text = String(x!)
    emailLabel.text = UserDefaults.standard.object(forKey: "email") as? String;
    prenomLabel.text = UserDefaults.standard.object(forKey: "firstname") as? String;
    phoneLabel.text = UserDefaults.standard.object(forKey: "phoneUser") as? String;
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
       

        
    }
    
    @IBAction func getPro(_ sender: Any) {
        
        
        
        Register()
        
    }
    
    
    func Register(){
        let parameters = ["id": UserDefaults.standard.object(forKey: "idUser") as? String]
        let idu = UserDefaults.standard.object(forKey: "idUser") as? Int;
        let x = String(idu!)
        AF.request("http://localhost:3000/getpro/"+x, method: .post,  parameters: parameters as Parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            print(json["message"] as! String)
                            let msg = json["message"] as! String
                            if(msg == "You're Registerd Successfully"){
                            
                                
                                 
                                  //  self.performSegue(withIdentifier: "addphone", sender: self)
                                self.performSegue(withIdentifier: "addPrest", sender: self)
                                print("hello")
                                
                            }
                            else {
                                print("already pro")
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
            }
        
        
    }
    
    @IBAction func log(_ sender: Any) {
        print("bouba")
        if let appDomain = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
            
         }
        self.performSegue(withIdentifier: "logginout", sender: self)
        print("skhat")
    }
    @IBAction func logout(_ sender: Any) {
     
    }
    
}
