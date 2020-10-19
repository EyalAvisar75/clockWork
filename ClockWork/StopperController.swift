//
//  StopperController.swift
//  ClockWork
//
//  Created by eyal avisar on 13/10/2020.
//

import UIKit

class StopperController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var buttonsPad: UIStackView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel! {
        didSet{
            timeLabel.font = UIFont.monospacedDigitSystemFont(
                ofSize: UIFont.systemFontSize * 2,
                weight: UIFont.Weight.regular)
        }
    }
    
    var stopperTimesTable = UITableView()
    var heightConstraint:NSLayoutConstraint?
    var isInvalidated = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftButton.alpha = 0
        rightButton.alpha = 0
        
        setStopperTimesTable()
//        stopperTimesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//
//        view.addSubview(stopperTimesTable)
//
//        stopperTimesTable.translatesAutoresizingMaskIntoConstraints = false
//        stopperTimesTable.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
//        stopperTimesTable.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
//        stopperTimesTable.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
//
//        //100 = cellHeight better create a constant and use here and at cellforrowAt create and activate constraint here, deactivate, recreate and activate at flagStopper func with condition after reload
////        if CGFloat((stopperTimes.count + 1)) * 100.00 < view.frame.height * 0.75 {
////            stopperTimesTable.bottomAnchor.constraint(equalTo: buttonsPad.centerYAnchor, constant: -1 * buttonsPad.frame.height).isActive = true
////        }
//
//        stopperTimesTable.bottomAnchor.constraint(equalTo: buttonsPad.centerYAnchor, constant: -1 * buttonsPad.frame.height).isActive = true
//
//        stopperTimesTable.alpha = 0
//        stopperTimesTable.dataSource = self

    }
    
    func setStopperTimesTable() {
        stopperTimesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
        view.addSubview(stopperTimesTable)
            
        stopperTimesTable.translatesAutoresizingMaskIntoConstraints = false
        stopperTimesTable.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        stopperTimesTable.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        stopperTimesTable.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        setHeightConstraint(cells: 0)
//        let height:CGFloat = 800
//        heightConstraint = NSLayoutConstraint(item: stopperTimesTable, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
//        heightConstraint?.isActive = true

//        ???stopperTimesTable.heightAnchor???instead of bottom anchor?
        //100 = cellHeight better create a constant and use here and at cellforrowAt create and activate constraint here, deactivate, recreate and activate at flagStopper func with condition after reload
//        if CGFloat((stopperTimes.count + 1)) * 100.00 < view.frame.height * 0.75 {
//            stopperTimesTable.bottomAnchor.constraint(equalTo: buttonsPad.centerYAnchor, constant: -1 * buttonsPad.frame.height).isActive = true
//        }
        
//        stopperTimesTable.bottomAnchor.constraint(equalTo: buttonsPad.centerYAnchor, constant: -1 * buttonsPad.frame.height).isActive = true
        
        stopperTimesTable.alpha = 0
        stopperTimesTable.dataSource = self

    }
    
    func setHeightConstraint(cells:Int) {
        if stopperTimes.count > 0 {
            timeLabel.alpha = 0
        }
        
        heightConstraint?.isActive = false
        var measure = stopperTimes.count < 2 ? 300 : 175
        if stopperTimes.count > 3 {
            measure = 150
        }
        
        var height:CGFloat = CGFloat(cells * measure)
        height = height > view.frame.height * 0.8 ? view.frame.height * 0.8 : height
        heightConstraint = NSLayoutConstraint(item: stopperTimesTable, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        heightConstraint?.isActive = true
    }
    
    //MARK: IBAction funcs
    
    @IBAction func switchButtons(_ sender: UIButton) {
        let buttonTitle = sender.title(for: .normal)

        switch buttonTitle {
        case "Run":
            startTimer(sender)
            if rightButton.titleLabel?.text == "Run" {
                rightButton.setTitle("Pause", for: .normal)
                rightButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                leftButton.setTitle("Flag", for: .normal) //Stop
                leftButton.setImage(UIImage(systemName: "flag.fill"), for: .normal)
            }
        case "Pause":
            rightButton.setTitle("Run", for: .normal)
            rightButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            leftButton.setTitle("Reset", for: .normal) //Stop
            leftButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            pauseTimer(sender)
        case "Flag":
            flagStopperCurrentTime(sender)
        default:
            if stopperTimes.count > 0 {
                stopperTimes = []
//                stopperTimesTable.alpha = 0
                stopperTimesTable.removeFromSuperview()
                stopperTimesTable = UITableView()
                setStopperTimesTable()
                timeLabel.alpha = 1
            }
            minutes = 0
            seconds = 0
            milliseconds = 0
            resetTimer(sender)
        }
    }
    
//    @IBAction func startTimer(_ sender: UIButton) {
    func startTimer(_ sender: UIButton) {
        isInvalidated = false
        leftButton.alpha = 1
        rightButton.alpha = 1
        runButton.alpha = 0
        
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
    
//    @IBAction func flagStopperCurrentTime(_ sender: UIButton) {
    func flagStopperCurrentTime(_ sender: UIButton) {
        stopperTimes.append((minutes, seconds, milliseconds))
        
        for time in stopperTimes {
            print(time)
        }
        
        setHeightConstraint(cells: stopperTimes.count)
        stopperTimesTable.reloadData()
        stopperTimesTable.alpha = 1
        startTimer(runButton)
    }
    
//    @IBAction func stopTimer(_ sender: Any) {
    func resetTimer(_ sender: Any) {
        isInvalidated = true
        timer?.invalidate()
        
        timer = nil
        
        rightButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        leftButton.setImage(UIImage(systemName: "flag.fill"), for: .normal)
        
        leftButton.alpha = 0
        rightButton.alpha = 0
        runButton.alpha = 1
        
        rightButton.setTitle("Pause", for: .normal)
        leftButton.setTitle("Flag", for: .normal)
        
        minutes = 0
        seconds = 0
        milliseconds = 0
        
        timeLabel.text = "00:00.00"
    }
    
    func pauseTimer(_ sender: Any) {
        isInvalidated = true
        timer?.invalidate()
    }
    
    @objc func fireTimer() {
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
        
        screenTime = "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds)).\(String(format: "%02d", screenMilliSeconds))"
        
        //supposed to solve "shaking text problem" but changes it to "ticking text problem"
        let attrString = NSMutableAttributedString(string: screenTime as String)
        attrString.addAttribute(NSAttributedString.Key.font, value: UIFont.monospacedDigitSystemFont(
                    ofSize: UIFont.systemFontSize,
                                            weight: UIFont.Weight.regular), range: NSMakeRange(attrString.length - 1, 1))

        timeLabel.attributedText = attrString
        
        if stopperTimes.count > 0 {
            let index = IndexPath(row: 0, section: 0)
            stopperTimesTable.reloadRows(at: [index], with: .none)
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
            
        let cellScreenTime = "\(String(format: "%02d", cellMinutes)):\(String(format: "%02d", cellSeconds)).\(String(format: "%02d", cellMilliseconds))"
        
        print("time: \(cellScreenTime)")
        cell.textLabel?.text = cellScreenTime
        return cell
    }
    
    
    
}
