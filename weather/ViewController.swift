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
    @IBOutlet weak var resultLabel: UILabel!

    
    func showError (){
        
       resultLabel.text = " \(userCity) is not correct! Try Again"

    }
    
    @IBAction func findWeather(sender: AnyObject) {
        
        
        //downloading website content
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + userCity.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        // check website exists
        if url != nil{
            let task = NSURLSession.sharedSession().dataTaskWithURL(url! , completionHandler: {(data, response, error) -> Void in
                var urlError = false
                var weather = ""
                if error == nil {
                    
                    //decoding
                    let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    
                    //check website html and get the city information from html content starting with this string
                    var urlContentArray = urlContent!.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray .count > 0{
                        
                        //stop the string here
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0] as String
                        
                        //replacing degree html code with degree sign
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")

                    }else{
                        urlError = true
                    }
                    
                }else{
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue()){
                    
                    if urlError == true{
                        self.showError()
                    }else{
                        
                        self.resultLabel.text = weather
                    }
                }
            })
            
            task.resume()
            
        } else{
            showError()
        }
        
        func textFieldShouldReturn(textField: UITextField!) -> Bool {
            
            textField.resignFirstResponder()
            
            return true
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

