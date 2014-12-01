//
//  InterfaceController.swift
//  BitWatch WatchKit Extension
//
//  Created by 张昊 on 14/12/1.
//  Copyright (c) 2014年 Razeware LLC. All rights reserved.
//

import WatchKit
import Foundation
import BitWatchKit

class InterfaceController: WKInterfaceController {

     var trc=Tracker()
    
    
    
    
    
    @IBOutlet weak var PriceLabel: WKInterfaceLabel!
    
    
    @IBOutlet weak var image: WKInterfaceImage!
    
    @IBOutlet weak var updateTime: WKInterfaceLabel!
    
    
    

    
    @IBAction func Refresh() {
        
        
        updateTimeZone(trc.cachedDate())
        updatePrice()
        println( "time is :\(NSDate())")
    }
    
    
    
    
    func updatePrice() {
        
        
        
        let oldPrice=trc.cachedPrice()
        
        trc.requestPrice { (price, error) -> () in
            
            if let err = error
            
            
            {
                println( "error is :\(err)")  }
            
            else{
                
                self.PriceLabel.setText(Tracker.priceFormatter.stringFromNumber(price!.doubleValue))
                
                self.updateImg(oldPrice, newPrice: price!)
            
                self.updateTimeZone(NSDate())
            }
         
            
            
            
            
            
        }
        
    }

    func  updateImg(oldPrice:NSNumber,newPrice:NSNumber) {
        
        
        if newPrice.isEqualToNumber(oldPrice){
        
        
        image.setHidden(true)
            
            
            
        
        }else {
        
            if newPrice.doubleValue > oldPrice.doubleValue{image.setImageNamed("Up")}
            else{image.setImageNamed("Down")}
        
        
        image.setHidden(false)
        
        
        
        }
        

        
    }

    func updateTimeZone(date:NSDate) {
        
   
        updateTime.setText(Tracker.dateFormatter.stringFromDate(date))
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        
        Refresh()
        
        // Configure interface objects here.
        NSLog("%@ init", self)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

}
