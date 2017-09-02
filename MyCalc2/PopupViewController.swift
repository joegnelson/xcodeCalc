//
//  PopupViewController.swift
//  MyCalc2
//
//  Created by Joseph Nelson on 9/18/16.
//  Copyright © 2016 Joseph Nelson. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var uiTextView: UITextView!
    var myInformation:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        showAnimate()
        
        uiTextView.text=calc.answerBarTotal
        uiTextView.isScrollEnabled = true
        //PopupLabel = self.view.superview;
        // Do any additional setup after loading the view.
    }
    
//    override func prepare(for segue: UIStoryboardSegue,
//                          sender: Any?){
//        if segue.identifier == "MySegueID" {
//            if let destination = segue.destination as? PopupViewController {
//                destination.myInformation = self.myInformation
//
//            }
//        }
//    }
    @IBAction func closeBttnTouchUpInside(_ sender: AnyObject) {
        //self.view.removeFromSuperview()
        removeAnimate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
