//
//  LoginView.swift
//  demo
//
//  Created by Dealjava on 2/26/16.
//  Copyright © 2016 originesia. All rights reserved.
//

import UIKit

let URLlogin = "http://labs.originesia.xyz/api/login.php";

class LoginView: UIView {


    @IBOutlet weak var username : UITextField!;
    @IBOutlet weak var password : UITextField!;
    @IBOutlet weak var loginBttn : UIButton!;
    @IBOutlet weak var closeBttn : UIButton!;
    @IBOutlet weak var indicator : UIActivityIndicatorView!;
    
    var action : loginHandler? = nil;
    
    typealias loginHandler = (respon : AnyObject! , error : NSError!) -> Void

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
    }
    
    override func layoutSubviews() {
        
    }
    
    override func awakeFromNib() {
        loginBttn.layer.cornerRadius = 5;
        loginBttn.layer.masksToBounds = true;
        loginBttn.addTarget(self, action: "signIn", forControlEvents: .TouchUpInside);
        
        closeBttn.addTarget(self, action: "hide", forControlEvents: .TouchUpInside);
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 5;
        
        indicator.stopAnimating();
    }
    
    func signIn(){
        if loginBttn.enabled {
            if username.text?.characters.count != 0 && password.text?.characters.count != 0 {
                self.endEditing(true);
                username.enabled = false;
                password.enabled = false;
                indicator.startAnimating();
                loginBttn.enabled = false;
                
                URLsession.sharedInstance().sentURL(URLlogin, methods: POST, withParams:["username":username.text!,"password":password.text!] , blocks: {[unowned self](respon :AnyObject!,urlRespon :NSURLResponse! , error : NSError!)in
                    dispatch_async(dispatch_get_main_queue(), {
                        self.username.enabled = true;
                        self.password.enabled = true;
                        self.indicator.stopAnimating();
                        self.loginBttn.enabled = true;
                    });
                    
                    if (self.action != nil) {
                        self.action!(respon: respon,error:  error);
                    }
                    });
            }
        }
        
    }
    
    func hide(){
        URLsession.sharedInstance().clearAllSession();
    }
    
    func show( handler:loginHandler){
        action = handler;
    }

}

class loginviewControl : UIView {
    
    var login :LoginView!;
    
    var action : loginHandler? = nil;
    
    typealias loginHandler = (respon : AnyObject! , error : NSError!) -> Void
    
    override init(frame : CGRect){
        super.init(frame: frame);
        self.backgroundColor = UIColor(white: 0.5, alpha: 0.5);
        login = NSBundle.mainBundle().loadNibNamed("LoginView", owner: self, options:nil)![0] as! LoginView;
        
        
        login.show({[unowned self] (respon : AnyObject! , error : NSError!)in
            if (self.action != nil) {
                self.action!(respon: respon,error:  error);
            }
        })
        let tap = UITapGestureRecognizer(target: self, action: "hiddenkeyboard");
        self.addGestureRecognizer(tap);
        self.addSubview(login);
    }
    func hiddenkeyboard(){
        self.endEditing(true);
    }
    
    func hide(){
        dispatch_async(dispatch_get_main_queue(), {
            self.endEditing(true);
            self.removeFromSuperview();
        });
    }
    
    func show(handler : loginHandler){
        UIApplication.sharedApplication().keyWindow?.addSubview(self);
        action = handler;
    }
    
    override func layoutSubviews() {
        self.frame = (UIApplication.sharedApplication().keyWindow?.bounds)!;
        login.frame = CGRectMake(0, 60, 300, 200);
        login.center.x = self.center.x;

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
