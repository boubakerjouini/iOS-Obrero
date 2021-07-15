//
//  PhoneViewController.swift
//  obrero_final
//
//  Created by boubakerjouini on 18/6/2021.
//

import UIKit
import Alamofire

class PhoneViewController: UIViewController {

    
    var id: Int = Int()
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var phoneField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("phone controller")
        print(id)
    }
    
    @IBAction func submit(_ sender: Any) {
        Register()
    }
    
    func Register(){
        let parameters = ["phone": phoneField.text!]
        AF.request("http://localhost:3000/phone/"+String(id), method: .post,  parameters: parameters as Parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            print(json["message"] as! String)
                            let msg = json["message"] as! String
                            if(msg == "You're Registerd Successfully"){
                                print("debug1")
                                UserDefaults.standard.set(self.phoneField, forKey: "phoneUser")
                                self.performSegue(withIdentifier: "confirmMail", sender: self)
                             
                                
                            }
                            else {
                               
                            }
                        }
                    case .failure(let error):
                        print("error")
                    }
            }
        
        
    }

}
