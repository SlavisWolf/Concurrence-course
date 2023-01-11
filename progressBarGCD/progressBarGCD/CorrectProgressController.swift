//
//  GoodProgressController.swift
//  progressBarGCD
//
//  Created by Antonio Jesús on 13/11/22.
//

import UIKit

class CorrectProgressController: UIViewController {
    
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var pauseBtn: UIButton!
    
    
    var timer: Timer?
    var seconds = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }

    
    
    @IBAction func start() {
        
        if seconds == 60 {
            seconds = 0
        }
        
        startBtn.isEnabled = false
        pauseBtn.isEnabled = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            DispatchQueue.global().async {
                self.seconds += 1
                if self.seconds == 60 {
                    timer.invalidate()
                    DispatchQueue.main.async {
                        self.progressBar.progress = 1.0
                        self.startBtn.isEnabled = true
                        self.pauseBtn.isEnabled = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.progressBar.progress = Float(self.seconds) / 60
                    }
                }
            }
        }
    }
    
    @IBAction func pause() {
        timer?.invalidate()
        pauseBtn.isEnabled = false
        startBtn.isEnabled = true
    }
}
