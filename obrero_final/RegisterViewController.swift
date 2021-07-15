//
//  RegisterViewController.swift
//  obrero_final
//
//  Created by boubakerjouini on 18/6/2021.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatpassword: UITextField!
    
    @IBOutlet weak var submit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    

    @IBAction func submit(_ sender: Any) {
        Register()

    }
    
    
    func Register(){
        let parameters = ["email": mail.text!,"password": password.text!, "username": username.text!,"firstname":fname.text!, "lastname": lname.text!]
        AF.request("http://localhost:3000/signup", method: .post,  parameters: parameters as Parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            print(json["message"] as! String)
                            let msg = json["message"] as! String
                            if(msg == "You're Registerd Successfully"){
                            
                                
                                    self.mail.text = ""
                                    self.username.text = ""
                                    self.password.text = ""
                                    self.repeatpassword.text = ""
                                  //  self.performSegue(withIdentifier: "addphone", sender: self)
                                self.performSegue(withIdentifier: "gotologin", sender: self)
                                print("hello")
                                
                            }
                            else {
                                self.createAlert(title: "Failed", message: msg)
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
            }
        
        
    }
    
    func createAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

