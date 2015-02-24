/*
*  Copyright (c) 2015, Parse, LLC. All rights reserved.
*
*  You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
*  copy, modify, and distribute this software in source code or binary form for use
*  in connection with the web services and APIs provided by Parse.
*
*  As with any software that integrates with the Parse platform, your use of
*  this software is subject to the Parse Terms of Service
*  [https://www.parse.com/about/terms]. This copyright notice shall be
*  included in all copies or substantial portions of the software.
*
*  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
*  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
*  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
*  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
*  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*
*/

import UIKit

import Parse
import ParseUI

enum UIDemoType : Int {
    case LogInDefault
    case LogInUsernamePassword
    case LogInPasswordForgotten
    case LogInDone
    case LogInEmailAsUsername
    case LogInFacebook
    case LogInFacebookAndTwitter
    case LogInAll
    case LogInAllNavigation
    case LogInCustomizedLogoAndBackground

    static var count: Int {
        var count = 0
        while let _ = self(rawValue: ++count) { }
        return count
    }
}

extension UIDemoType : Printable {

    var description: String {
        switch (self) {
        case LogInDefault:
            return "Log In Default"
        case LogInUsernamePassword:
            return "Log In Username and Password"
        case LogInPasswordForgotten:
            return "Log In Password Forgotten"
        case LogInDone:
            return "Log In Done Button"
        case LogInEmailAsUsername:
            return "Log In Email as Username"
        case LogInFacebook:
            return "Log In Facebook"
        case LogInFacebookAndTwitter:
            return "Log In Facebook and Twitter"
        case LogInAll:
            return "Log In All"
        case LogInAllNavigation:
            return "Log In All as Navigation"
        case LogInCustomizedLogoAndBackground:
            return "Log In Customized Background"
        }
    }

}

class UIDemoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ParseUI Demo"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension UIDemoViewController : UITableViewDataSource {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UIDemoType.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = UIDemoType(rawValue: indexPath.row)?.description
        return cell
    }
}

extension UIDemoViewController : UITableViewDelegate {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let demoType = UIDemoType(rawValue: indexPath.row) {
            switch (demoType) {
                // -----
                // PFLogInViewController
                // -----
            case .LogInDefault:
                let logInViewController = PFLogInViewController()
                logInViewController.delegate = self
                presentViewController(logInViewController, animated: true, completion: nil)
            case .LogInUsernamePassword:
                let logInViewController = PFLogInViewController()
                logInViewController.delegate = self
                logInViewController.fields = .UsernameAndPassword | .DismissButton
                presentViewController(logInViewController, animated: true, completion: nil)
            case .LogInPasswordForgotten:
                let logInViewController = PFLogInViewController()
                logInViewController.delegate = self
                logInViewController.fields = .UsernameAndPassword | .PasswordForgotten | .DismissButton
                presentViewController(logInViewController, animated: true, completion: nil)
            case .LogInDone:
                let logInViewController = PFLogInViewController()
                logInViewController.delegate = self
                logInViewController.fields = .UsernameAndPassword | .LogInButton | .DismissButton
                presentViewController(logInViewController, animated: true, completion: nil)
            case .LogInEmailAsUsername:
                let logInViewController = PFLogInViewController()
                logInViewController.delegate = self
                logInViewController.fields = .UsernameAndPassword | .LogInButton | .SignUpButton | .DismissButton
                logInViewController.emailAsUsername = true
                presentViewController(logInViewController, animated: true, completion: nil)
            case .LogInFacebook:
                let logInViewController = PFLogInViewController()
                logInViewController.delegate = self
                logInViewController.fields = .UsernameAndPassword | .Facebook | .DismissButton
                presentViewController(logInViewController, animated: true, completion: nil)
            case .LogInFacebookAndTwitter:
                let logInViewController = PFLogInViewController()
                logInViewController.delegate = self
                logInViewController.fields = .Facebook | .Twitter | .DismissButton
                presentViewController(logInViewController, animated: true, completion: nil)
            case .LogInAll:
                let logInViewController = PFLogInViewController()
                logInViewController.delegate = self
                logInViewController.fields = .UsernameAndPassword | .PasswordForgotten | .LogInButton | .Facebook | .Twitter | .SignUpButton | .DismissButton
                if let signUpController = logInViewController.signUpController {
                    signUpController.delegate = self
                    signUpController.fields = .UsernameAndPassword | .Email | .Additional | .SignUpButton | .DismissButton
                }
                presentViewController(logInViewController, animated: true, completion: nil)
            case .LogInAllNavigation:
                let logInViewController = PFLogInViewController()
                logInViewController.delegate = self
                logInViewController.fields = .UsernameAndPassword | .PasswordForgotten | .LogInButton | .Facebook | .Twitter | .SignUpButton | .DismissButton
                if let signUpViewController = logInViewController.signUpController {
                    signUpViewController.delegate = self
                    signUpViewController.fields = .UsernameAndPassword | .Email | .Additional | .SignUpButton | .DismissButton
                }
                navigationController?.pushViewController(logInViewController, animated: true)
            case .LogInCustomizedLogoAndBackground:
                let logInViewController = CustomLogInViewController()
                logInViewController.delegate = self
                logInViewController.fields = .Default | .Facebook | .Twitter

                let signUpViewController = CustomSignUpViewController()
                signUpViewController.delegate = self
                signUpViewController.fields = .Default

                logInViewController.signUpController = signUpViewController
                presentViewController(logInViewController, animated: true, completion: nil)
            }
        }
    }

}

extension UIDemoViewController : PFLogInViewControllerDelegate {

    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension UIDemoViewController : PFSignUpViewControllerDelegate {

    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
