//
//  LoginViewController.swift
//  AIPR
//
//  Created by Patrick Elisii on 3/22/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true{
            performSegue(withIdentifier: "loginSuccess", sender: self)
        }
    }
    
    @IBAction func onTapgesture(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func onLogin(_ sender: Any) {
        let usrname = usernameField.text!
        let pass = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: usrname, password: pass)
        { (user, error) in
            if user != nil{
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
            }
            else{
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                print("error: \(error?.localizedDescription)")
            }
            
        }
    }
    
    @IBAction func onSignup(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.signUpInBackground { (success, error) in
            if success{
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
            }
            else{
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                print("error: \(error?.localizedDescription)")
            }
        }
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
