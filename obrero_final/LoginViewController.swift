//
//  LoginViewController.swift
//  obrero_final
//
//  Created by boubakerjouini on 18/6/2021.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var idu: Int = Int ()
    var phoneU: String = ""
    var firstname: String = ""
    var lastname: String = ""
    var username: String = ""
    var role: Int = Int()
    var etat: Int = Int()
    var mail: String = ""

    @IBOutlet weak var userLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

                
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "lastname") as? String{
                print(x)
            
              //  userLabel.text = String(x);
            self.performSegue(withIdentifier: "menu", sender: self)
            
        }

    }
    
    
    func log () {
        let parameters = ["username": email.text,"password": password.text]
        AF.request("http://localhost:3000/login", method: .post,  parameters: parameters as Parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            print(json["message"] as! String)
                            let msg = json["message"] as! String
                            if(msg == "login successfull"){
                                self.idu = json["id"] as! Int
                                self.phoneU = json["phone"] as! String
                                self.firstname = json["firstname"] as! String
                                self.lastname = json["lastname"] as! String
                                self.username = json["username"] as! String
                                self.role = json["role"] as! Int
                                self.etat = json["etat"] as! Int
                                self.mail = json["email"] as! String

                                print("i'm inside the login process " + String(self.idu))
                                self.email.text = ""
                                self.password.text = ""
                               // self.performSegue(withIdentifier: "phoneAdd", sender: self)
                                print(self.phoneU)
                                
                                
                            //User logs infos
                                UserDefaults.standard.set(self.idu, forKey: "idUser")
                                UserDefaults.standard.set(self.phoneU, forKey: "phoneUser")
                                UserDefaults.standard.set(self.username, forKey: "username")
                                UserDefaults.standard.set(self.mail, forKey: "email")
                                UserDefaults.standard.set(self.firstname, forKey: "firstname")
                                UserDefaults.standard.set(self.lastname, forKey: "lastname")
                                UserDefaults.standard.set(self.role, forKey: "role")
                                UserDefaults.standard.set(self.etat, forKey: "etat")

                                
                                
                                
                                if(self.phoneU == "null") {
                                    self.performSegue(withIdentifier: "phoneAdd", sender: self)
                                }
                                else {
                                    self.performSegue(withIdentifier: "menu", sender: self)
                                }
                                
                            }
                            else {
                                self.password.text = ""
                                self.createAlert(title: "Failed", message: msg)
                                
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
            }
    }

    @IBAction func login(_ sender: Any) {
        
        log()
        //performSegue(withIdentifier: "login", sender: self)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PhoneViewController {
            destination.id = idu
            print(String(idu))
        }
    }
    
    func createAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    
}
