//
//  ClockFunctionsController.swift
//  ClockWork
//
//  Created by eyal avisar on 27/10/2020.
//

import UIKit

class ClockFunctionsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func loadClock(_ sender: UIBarItem) {
        guard let clockVC = storyboard?.instantiateViewController(withIdentifier: "clock") else {
            return
        }
        navigationController?.pushViewController(clockVC, animated: true)
    }
    
    @IBAction func loadSetAlarm(_ sender: UIBarItem) {
        
    }
    
    @IBAction func loadStopper(_ sender: UIBarItem) {
        guard let stopperVC = storyboard?.instantiateViewController(withIdentifier: "stopper") else {
            return
        }
        navigationController?.pushViewController(stopperVC, animated: true)
    }
    
    @IBAction func loadTimer(_ sender: UIBarItem) {
        guard let timerVC = storyboard?.instantiateViewController(withIdentifier: "timer") else {
            return
        }
        navigationController?.pushViewController(timerVC, animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
