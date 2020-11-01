//
//  ClockController.swift
//  ClockWork
//
//  Created by eyal avisar on 27/10/2020.
//

import UIKit

class ClockController: UIViewController {
    
    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let timeZoneIdentifiers = TimeZone.knownTimeZoneIdentifiers
        print(timeZoneIdentifiers)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    

    @objc func fireTimer() {
        
        let now = Date()
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        
        let screenHour = "\(String(format: "%02d", dateComponents.hour!) ):\(String(format: "%02d", dateComponents.minute!)):\(String(format: "%02d", dateComponents.second!))"
        let screenDate = "current:\(dateComponents.day!).\(dateComponents.month!).\(dateComponents.year!)"
        
        hourLabel.text = screenHour
        dateLabel.text = screenDate
    }

}
