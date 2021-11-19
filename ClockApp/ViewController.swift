//
//  ViewController.swift
//  ClockApp
//
//  Created by David Svensson on 2021-11-18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    let formatter = DateFormatter()
    
    var timer: Timer?
    
    let startTime = 60.0
    
    var player1time = 0.0
    var player2time = 0.0
    var player1active = true
    
    var lastTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetPlayerTime()
        
        updateTimelabel()
    }
    
    func resetPlayerTime() {
        player1time = startTime
        player2time = startTime
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        if timer != nil  {
            switchPlayer()
        } else {
            startClock()
        }
    }
    
    func switchPlayer() {
        player1active.toggle()
        updateTime()
    }
    
    func startClock() {
        resetPlayerTime()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateTime(timer:))
        lastTime = Date()
    }
    
    func updateTime(timer: Timer? = nil) {
        
        let newTime = Date()
        let deltaTime = newTime.timeIntervalSince(lastTime)
        
        if player1active {
            player1time -= deltaTime
        } else {
            player2time -= deltaTime
        }
        
        updateTimelabel()
        
        if player2time < 0 || player1time < 0 {
            timer?.invalidate()
        }
        
        lastTime = newTime
    }
    
    func updateTimelabel() {
        let newTimeString = "\(String(format: "%.1f", player1time))   :   \(String(format: "%.1f", player2time))"
        
        timeLabel.text = newTimeString
    }
    
    deinit {
        timer?.invalidate()
    }
}
