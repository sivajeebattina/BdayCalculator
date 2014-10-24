//
//  BdayCalculatorViewController.swift
//  BdayCalculator
//
//  Created by pcs20 on 10/22/14.
//  Copyright (c) 2014 Paradigmcreatives. All rights reserved.
//

import UIKit

class BdayCalculatorViewController: UIViewController {
    
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var daysLabel:UILabel!
    @IBOutlet var weeksLabel:UILabel!
    @IBOutlet var monthsLabel:UILabel!
    @IBOutlet var bdayPersonNameTextField:UITextField!
    
    @IBOutlet var chooseButton:UIButton!
    @IBOutlet var registerButton:UIButton!
    @IBOutlet var todayBdaysButton:UIButton!
    
    
    var DatePicker:UIDatePicker=UIDatePicker()
    var dateFormatter:NSDateFormatter=NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dateLabel.text=""
        dateFormatter.dateFormat="dd-MM-yyyy"
    
    
    }

  
    
    
    @IBAction func registerClicked(sender:AnyObject){
        if (!self.bdayPersonNameTextField.text.isEmpty && (self.dateLabel.text?.isEmpty) != nil)
        {
            
            
            if (self.daysLabel.text=="Days: 0")
            {
                var localNotificatoin=UILocalNotification()
                
                localNotificatoin.fireDate=DatePicker.date.dateByAddingTimeInterval(3600)
                localNotificatoin.alertBody=String(format:"%@",bdayPersonNameTextField.text)
                localNotificatoin.timeZone=NSTimeZone.defaultTimeZone()
                localNotificatoin.alertAction="Show me this notification"
                localNotificatoin.applicationIconBadgeNumber=UIApplication.sharedApplication().applicationIconBadgeNumber+1
                UIApplication.sharedApplication().scheduleLocalNotification(localNotificatoin)
                NSNotificationCenter.defaultCenter().postNotificationName("reloadData", object: self)
                
                
                //resetting everything
                self.daysLabel.text="Days: ";
                self.monthsLabel.text="Months: ";
                self.weeksLabel.text="Weeks: ";
                self.bdayPersonNameTextField.text=nil;
                self.dateLabel.text="";
            }
            
            else{
                
                //resetting everything
                self.daysLabel.text="Days: ";
                self.monthsLabel.text="Months: ";
                self.weeksLabel.text="Weeks: ";
                self.bdayPersonNameTextField.text=nil;
                self.dateLabel.text="";
                
            }
            
        }
        
        else
        {
        
            
            var alert:UIAlertView=UIAlertView()
            alert.title="Some Information Missing!"
            alert.message="You haven't entered Bday person Name or Date "
            alert.addButtonWithTitle("OK")
        
            alert.show()
        
        }
        
        
    }

    
    @IBAction func chooseButtonClicked(sender:AnyObject){
        
       
        DatePicker.datePickerMode=UIDatePickerMode.Date
    
        
        var alert:UIAlertView=UIAlertView()
        alert.title="Choose Date"
        alert.message=" "
        alert.addButtonWithTitle("OK")
        alert.cancelButtonIndex=1;
        alert.addButtonWithTitle("Cancel")
        alert.delegate=self
        alert .setValue(DatePicker, forKey: "accessoryView")
        alert.show()

    }
    
    
    @IBAction func todayBdaysButtonClicked(sender:AnyObject){
        var storyBoard=UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        var daypersonTable:BdayPersonsTableViewController=storyBoard.instantiateViewControllerWithIdentifier("bdayPersons") as BdayPersonsTableViewController
        self.navigationController?.pushViewController(daypersonTable as UIViewController, animated: true)
        
    }
   
    
func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        switch buttonIndex{
        
       
        case 0:
            self.dateLabel.text=dateFormatter.stringFromDate(DatePicker.date)
           
            
           var CurrentDate=NSDate.date()
           var GregorianCalender=NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
            let unit:NSCalendarUnit = .DayCalendarUnit
           var dayscomponents = GregorianCalender.components(unit, fromDate: DatePicker.date, toDate: CurrentDate, options: nil)
            
           var monthComponents=GregorianCalender.components(.MonthCalendarUnit, fromDate: DatePicker.date, toDate: NSDate(), options: nil)
          
           self.daysLabel.text="Days: \(dayscomponents.day)"
           self.weeksLabel.text="Weeks: \(dayscomponents.day/7)"
           self.monthsLabel.text="Months: \(monthComponents.month)"
            
          DatePicker=UIDatePicker()
        default:
            print("Cancel clicked")
            DatePicker=UIDatePicker()
            
                           }
     }
    
    
}