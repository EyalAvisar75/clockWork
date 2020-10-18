//
//  StopperController.swift
//  ClockWork
//
//  Created by eyal avisar on 13/10/2020.
//

import UIKit

class StopperController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var buttonsPad: UIStackView!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel! {
        didSet{
            timeLabel.font = UIFont.monospacedDigitSystemFont(
                ofSize: UIFont.systemFontSize * 2,
                weight: UIFont.Weight.regular)
        }
    }
    
    var stopperTimesTable = UITableView()
    var isInvalidated = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopperTimesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
        view.addSubview(stopperTimesTable)
            
        stopperTimesTable.translatesAutoresizingMaskIntoConstraints = false
        stopperTimesTable.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        stopperTimesTable.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        stopperTimesTable.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        //100 = cellHeight better create a constant and use here and at cellforrowAt create and activate constraint here, deactivate, recreate and activate at flagStopper func with condition after reload
//        if CGFloat((stopperTimes.count + 1)) * 100.00 < view.frame.height * 0.75 {
//            stopperTimesTable.bottomAnchor.constraint(equalTo: buttonsPad.centerYAnchor, constant: -1 * buttonsPad.frame.height).isActive = true
//        }
        
        stopperTimesTable.bottomAnchor.constraint(equalTo: buttonsPad.centerYAnchor, constant: -1 * buttonsPad.frame.height).isActive = true
        
        stopperTimesTable.alpha = 0
        stopperTimesTable.dataSource = self

    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        isInvalidated = false
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        //        var lastRunningTime = "\(String(format: "%.2f", lastStartDate.distance(to: Date())))"
                
        //        let queue = DispatchQueue(label: "runTime queue")
        //        queue.async {
                    
        //            let runTime = "\(String(format: "%.2f", lastStartDate.distance(to: Date())))"
        //            if runTime != lastRunningTime {
        //                print("\(runTime), \(lastRunningTime)")
        //                lastRunningTime = runTime
                        
        //            }
        //        }
                
        //        timeLabel.text = "\(String(format: "%.2f", lastRunningTime))"
    }
    
    @IBAction func flagStopperCurrentTime(_ sender: UIButton) {
        stopperTimes.append((minutes, seconds, milliseconds))
        
        for time in stopperTimes {
            print(time)
        }
        
        stopperTimesTable.reloadData()
        stopperTimesTable.alpha = 1
        startTimer(runButton)
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        isInvalidated = true
        timer?.invalidate()
    }
    
    @objc func fireTimer() {
//        print("Timer fired! \(milliseconds)")
        if isInvalidated {
            return
        }
        var screenTime = ""
        milliseconds += 0.01
        let screenMilliSeconds = Int(milliseconds * 100)
        
        if milliseconds >= 1 {
            seconds += 1
            milliseconds = 0
            
        }
        
        if seconds >= 60 {
            minutes += 1
            seconds = 0
        }
        
        screenTime = "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds)):\(String(format: "%02d", screenMilliSeconds))"
        
        //supposed to solve "shaking text problem" but changes it to "ticking text problem"
        let attrString = NSMutableAttributedString(string: screenTime as String)
        attrString.addAttribute(NSAttributedString.Key.font, value: UIFont.monospacedDigitSystemFont(
                    ofSize: UIFont.systemFontSize,
                                            weight: UIFont.Weight.regular), range: NSMakeRange(attrString.length - 1, 1))

        timeLabel.attributedText = attrString
//        timeLabel.text = screenTime
        
        if stopperTimes.count > 0 {
            let index = IndexPath(row: 0, section: 0)
            stopperTimesTable.reloadRows(at: [index], with: .automatic)
        }
    }
    
    //MARK: table datasource funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("#cells = \(stopperTimes.count + 1)")
        return stopperTimes.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        if indexPath.row == 0 {
            stopperTimesTable.rowHeight = 100.0
            
            cell.textLabel?.text = timeLabel.text
            cell.textLabel?.font = UIFont.systemFont(ofSize: 30.0)
//            cell.textLabel?.font.withSize(30)
            return cell
        }
        
        stopperTimesTable.rowHeight = 50.0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
        let stopperTimeIndex = stopperTimes.count - indexPath.row
        let cellMinutes = stopperTimes[stopperTimeIndex].0
        let cellSeconds = stopperTimes[stopperTimeIndex].1
        let cellMilliseconds = Int(stopperTimes[stopperTimeIndex].2 * 100)
            
        let cellScreenTime = "\(String(format: "%02d", cellMinutes)):\(String(format: "%02d", cellSeconds)):\(String(format: "%02d", cellMilliseconds))"
        
        print("time: \(cellScreenTime)")
        cell.textLabel?.text = cellScreenTime
        return cell
    }
    
}
