//
//  ViewController.swift
//  MyCalc2
//
//  Created by Joseph Nelson on 9/1/16.
//  Copyright © 2016 Joseph Nelson. All rights reserved.
//

import UIKit


//--------------------------------------------------------------------------
class ViewController: UIViewController {

    var myInformation:String = ""

    @IBOutlet weak var ModeBttn: UIButton!
    var modeBool:Bool = true
    @IBOutlet weak var answerBar: UILabel!
//    @IBOutlet weak var ansewrBarFull: UILabel!
    @IBOutlet weak var messageBar: UILabel!
    
    @IBOutlet weak var plusBttn: UIButton!
    @IBOutlet weak var minusBttn: UIButton!
    @IBOutlet weak var equalsBttn: UIButton!
    var calc:Calc = Calc()
/*
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        let destination: PopupViewController = segue.destination as! PopupViewController
        destination.myInformation = self.myInformation
        
//        if segue.identifier == "MySegueID" {
//            if let destination = segue.destination as? PopupViewController {
//                destination.myInformation = self.myInformation
                
//            }
//        }
    }
    //    override func performSegue(withIdentifier identifier: String,
    //                      sender: Any?)
    //    {
    //        print("iu")
    //    }
*/    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! PopupViewController) 
                controller.myInformation = calc.answerBarTotal
//            }
//        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let test:CalTest = CalTest()
        let msg:String = test.test()
        messageBar.text = msg
        setButtonColor()
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("handleTap:")))
//        answerBar.addGestureRecognizer(gestureRecognizer)
    }
    
//    func handleTap(gestureRecognizer: UIGestureRecognizer) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "next")
//        self.present(vc, animated: true, completion: nil)
//    }
    
    @IBAction func showBttnTouchUpInside(_ sender: AnyObject) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopupId") as! PopupViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        myInformation=messageBar.text!
    }
    @IBAction func ModeBttnTouchUpInside(_ sender: AnyObject) {
        modeBool = !modeBool;
        setDisplays(calc)
    }
    func setDisplays(_ calc:Calc){
        if(modeBool){
            answerBar.text=calc.answerBar
//            ansewrBarFull.text=calc.answerBarTotal
        }else{
//            ansewrBarFull.text=calc.answerBar
            answerBar.text=calc.answerBarTotal
        }
        setButtonColor()
        messageBar.text = calc.print2()
        
    }
    func setButtonColor(){
        plusBttn.setTitleColor(UIColor.black, for:  UIControlState())
        minusBttn.setTitleColor(UIColor.black, for:  UIControlState())
        equalsBttn.setTitleColor(UIColor.black, for:  UIControlState())
        
        
        if(calc.currentMode==Calc.modes.addition){
            plusBttn.setTitleColor(UIColor.white, for:  UIControlState())
        }
        if(calc.currentMode==Calc.modes.subtaction){
            minusBttn.setTitleColor(UIColor.white, for:  UIControlState())
            
        }
        if(calc.currentMode==Calc.modes.equals){
            equalsBttn.setTitleColor(UIColor.white, for:  UIControlState())
        }

    }
    
    @IBAction  func numberTouchDown(_ sender: UIButton) {
        calc.number(sender.currentTitle!)
        setDisplays(calc)
        
    }
    
    
    @IBAction func plusButtonTouchUpInside(_ sender: AnyObject) {
        
        calc.plus()
        setDisplays(calc)
        setButtonColor()
    }

    @IBAction func minusButtonTouchUpInside(_ sender: AnyObject) {
        calc.minus()
        setDisplays(calc)
        setButtonColor()
    }
    
    @IBAction func equalsButtonTouchUpInside(_ sender: AnyObject) {
        calc.equals()
        setDisplays(calc)
        setButtonColor()
    }
    @IBAction func clearButtonTouchUpInside(_ sender: AnyObject) {
        calc.clear()
        setDisplays(calc)
        setButtonColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



//--------------------------------------------------------------------------
class Calc{
    enum modes{
        case not_SET
        case addition
        case subtaction
        case equals
    }
    enum action{
        case clear
        case number
        case addition
        case subtaction
        case equals
    }
    var currentNum:Int=0
    var totalNum:Int=0
    var currentMode:modes = modes.not_SET
    var lastAction:action=action.clear
    var answerBar:String="0"
    var answerBarTotal:String=""

    func print2()-> String{
        return "currentNum=\(currentNum)"
            + " totalNum=\(totalNum)"
            + " currentMode=\(currentMode)"
            + " lastAction=\(lastAction)"
    }
    
    @discardableResult func clear() -> Calc{
        currentNum=0
        totalNum=0
        currentMode = modes.not_SET
        answerBar="0"
        answerBarTotal=""
        lastAction=action.clear
        return self
    }
    
    
    @discardableResult func number(_ num:String) -> Calc{
        if( answerBar=="0" || !(currentMode==modes.not_SET ))
        {
            if(!(answerBar=="-") && !(lastAction==action.number) ){
                answerBar=""
            }
        }
        answerBarTotal+="\(num)"
        answerBar="\(answerBar)\(num)"
        lastAction=action.number
        return self
    }
    
    @discardableResult func plus() -> Calc{
        answerBarTotal+="+"
        if(lastAction==action.subtaction || lastAction==action.addition ){
            currentMode=modes.addition
        }
        else if(!(answerBar=="") && !(answerBar=="-")){
            
            currentNum = Int(answerBar)!
            
            operate()
            currentMode=modes.addition
            //answerBar="0"
            
        }
        lastAction=action.addition
        return self
    }
    
    @discardableResult func minus() -> Calc{
        answerBarTotal+="-"
        
        if(lastAction==action.subtaction || lastAction==action.addition ){
            currentMode=modes.subtaction
            lastAction=action.subtaction
            return self
        }
        else if(answerBar=="0"){
            answerBar="-"
            lastAction=action.subtaction
            return self
        }
        else if(answerBar=="-"){
            lastAction=action.subtaction
            return self
        }
        
        currentNum = Int(answerBar)!
        operate()
        //answerBar="0"
        currentMode=modes.subtaction
        
        
        lastAction=action.subtaction
        return self
    }
    @discardableResult func equals() -> Calc{
        answerBarTotal+="="
        if(!(answerBar=="") && !(answerBar=="-") && lastAction==action.number){
            currentNum = Int(answerBar)!
            operate()
        }
        currentNum=totalNum
        answerBar="\(totalNum)"
        answerBarTotal+="\(totalNum)|"

        currentMode=modes.equals
        lastAction=action.equals
        return self
    }
    @discardableResult fileprivate func operate() -> Calc{
        if((answerBar=="" || answerBar=="-")) {return self}
        
        if(currentMode==modes.addition ){
            totalNum=totalNum+currentNum
        }
        else if(currentMode==modes.subtaction ){
            totalNum=totalNum-currentNum
        }
        else{
            totalNum=currentNum
        }
        answerBar="\(totalNum)"
        return self
    }
    
}

//--------------------------------------------------------------------------
class CalTest{
    var count:Int=0
    var pass:Int=0
    var fail:Int=0
    var errors = [String]()
    
    func test() -> String{
        var msg:String=""
        msg = buildMessage(msg,testResults: testMultiPlus())
        msg = buildMessage(msg,testResults: testMinus())
        msg = buildMessage(msg,testResults: testNumberAfterEquals())
        msg = buildMessage(msg,testResults: testPlusAfterEquals())
        msg = buildMessage(msg,testResults: testPlusMinusEquals())
        
        return "Ran \(count) Test[pass:\(pass) fail:\(fail)]... \(msg)"
    }
    func buildMessage(_ msg:String,testResults:String)->String{
        if(testResults==""){return msg}
        return msg+"["+testResults+"]"
    }
    func error(_ methodName:String, msg:String) -> String{
        fail+=1
        return "ERROR: \(methodName): \(msg)"
    }
    //--
    func testZeroMinus() -> String{
        count+=1
        
        let methodName:String="testZeroMinus"
        let calc1:Calc = Calc()
        calc1.number("3").plus().number("0").minus()
        if(!( calc1.answerBar=="0")){return error( methodName,msg: "(3+0-) answerBar=\(calc1.answerBar)")}
        
        pass+=1
        return ""
        
    }
    func testPlusMinusEquals() -> String{
        count+=1
        
        let methodName:String="testPlusMinusEquals"
        let calc1:Calc = Calc()
        calc1.number("3").minus().number("63").plus().minus().equals()
        if(!( calc1.totalNum==(-60))){return error( methodName,msg: "(3-63+-=) totalNum=\(calc1.totalNum)")}
        
        pass+=1
        return ""
        
    }
    func testPlusAfterEquals() -> String{
        count+=1
        
        let methodName:String="testPlusAfterEquals"
        let calc1:Calc = Calc()
        calc1.number("3").minus().number("63").plus().equals()
        if(!( calc1.totalNum==(-60))){return error( methodName,msg: "(3-36+=-33) totalNum=\(calc1.totalNum)")}
        
        
        pass+=1
        return ""
        
    }
    func testNumberAfterEquals() -> String{
        count+=1
        
        let methodName:String="testNumberAfterEquals"
        let calc1:Calc = Calc()
        calc1.number("3").number("5").minus().number("5").equals().number("7").equals()
        if(!( calc1.totalNum==7)){return error( methodName,msg: "(35-5=7) totalNum=\(calc1.totalNum)")}
        
        
        pass+=1
        return ""
        
    }
    func testMultiPlus() -> String{
        count+=1
        let methodName:String="testMultiPlus"
        let calc1:Calc = Calc()
        calc1.number("3").number("2").plus().number("5").plus()
        if(!( calc1.answerBar=="37")){return error(methodName,msg: "didnt keep last num")}
        if(!( calc1.totalNum==37)){return error((methodName),msg: "(32+5+) totalNum=\(calc1.totalNum)")}
        calc1.number("7").equals()
        if(!( calc1.totalNum==44)){return error(methodName,msg: "(32+5+7) totalNum=\(calc1.totalNum)")}
        
        pass+=1
        return ""
        
    }
    func testMinus() -> String{
        count+=1
        let methodName:String="testMinus"
        let calc1:Calc = Calc()
        calc1.number("3").number("5").minus().number("5").equals()
        if(!( calc1.totalNum==30)){return error(methodName,msg: "(32-5) totalNum=\(calc1.totalNum)")}
        
        calc1.clear()
        calc1.minus()
        if(!(calc1.answerBar=="-")){return error(methodName,msg: "(-) answerBar=\(calc1.answerBar)")}
        calc1.number("3").number("5").minus()
        if(!(calc1.currentNum==(-35))){return error(methodName,msg: "(-35-) totalNum=\(calc1.totalNum)")}
        calc1.number("5").equals()
        if(!( calc1.totalNum==(-40))){return error(methodName,msg: "(-35-5) totalNum=\(calc1.totalNum)")}
        
        pass+=1
        return ""
        
    }
    
}
