//
//  ViewController.swift
//  weather
//
//  Created by Nima Farahani on 7/19/16.
//  Copyright © 2016 Nima Farahani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userCity: UITextField!
    
    func showError (){
        
        print( " \(userCity) is not correct! Try Again")

    }
    
    @IBAction func findWeather(sender: AnyObject) {
    }
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "http://www.weather-forecast.com/locations/New-York/forecasts/latest")
        
        if url != nil{
            let task = NSURLSession.sharedSession().dataTaskWithURL(url! , completionHandler: {(data, response, error) -> Void in
                var urlError = true
                
                if error == nil {
                    
                }else{
                    urlError = true
                }
                
                if urlError == true{
                    self.showError()
                }
                
            })
        } else{
            showError()
        }
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

