//
//  ConfirmPhoneViewController.swift
//  obrero_final
//
//  Created by boubakerjouini on 18/6/2021.
//

import UIKit
import Alamofire

class ConfirmPhoneViewController: UIViewController {

    @IBOutlet weak var codeLabel: UITextField!
    
    
    @IBOutlet weak var submit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "idUser") as? Int{
            print(x)
        }
        
        
    }
    
    
    @IBAction func submit(_ sender: Any) {
        log ()
    }
    
    func log () {
        let parameters = ["random": codeLabel.text]
        AF.request("http://localhost:3000/verif/"+codeLabel.text!, method: .post,  parameters: parameters as Parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            print(json["message"] as! String)
                            let msg = json["message"] as! String
                            if(msg == "login successfull"){
                                self.performSegue(withIdentifier: "menu1", sender: self)
                            }
                          
                        }
                    case .failure(let error):
                        print(error)
                    }
            }
    }
    
    
    

}
