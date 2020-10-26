//
//  TimerController.swift
//  ClockWork
//
//  Created by eyal avisar on 25/10/2020.
//

import UserNotifications
import UIKit

class TimerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var buttonsPad: UIStackView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let center = UNUserNotificationCenter.current()
        UNUserNotificationCenter.current().delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        
        timePicker.delegate = self
        timePicker.dataSource = self
        activityIndicator.alpha = 0
        timerLabel.alpha = 0
    }
    
    //MARK: UIPicker delegate and datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return 25
        case 1,2:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width / 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) :"
        case 1:
            return "\(row) :"
        case 2:
            return "\(row) "
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hours = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let buttonTitle = sender.title(for: .normal)
        
        switch buttonTitle {
        case "Center":
            timePicker.alpha = 0
            timerLabel.alpha = 1
//            activityIndicator.alpha = 1
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            
        case "Left":
            print("seconds \(seconds)")
        case "Right":
            print("hours \(minutes)")
        default:
            break
        }
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        let timeInterval = hours * 3600 + minutes * 60 + seconds
        let date = Date(timeIntervalSinceNow: TimeInterval(timeInterval))
//        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
         let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: false)

//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        center.add(request, withCompletionHandler: { (error) in
             if let error = error {
                print(error.localizedDescription)
             }
         })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            let userInfo = notification.request.content.userInfo
            print(userInfo) // the payload that is attached to the push notification
            // you can customize the notification presentation options. Below code will show notification banner as well as play a sound. If you want to add a badge too, add .badge in the array.
            completionHandler([.alert,.sound])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
               let userInfo = response.notification.request.content.userInfo
               // Print full message.
               print("tap on on foreground app",userInfo)
               completionHandler()
    }
    
    @objc func fireTimer() {
        
        if !isTimerRunning {
            timerStartTime = "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
            isTimerRunning = true
            scheduleNotification()
        }
        
        if hours == 0 && minutes == 0 && seconds == 0 {
            timerLabel.text = "00:00:00"
            timerStartTime = ""
            isTimerRunning = false
            timer?.invalidate()
            timer = nil
            return
        }
        
        var screenTime = ""
        
        if seconds <= 0 {
            seconds = minutes > 0 ? 59 : 0
            minutes = (minutes > 0) ? minutes - 1 : minutes
        }
        
        if minutes <= 0  {
            minutes = hours > 0 ? 59 : 0
            hours = (hours > 0) ? minutes - 1 : hours
        }
        
        screenTime = "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        timerLabel.text = screenTime
        seconds -= 1
    }

}
