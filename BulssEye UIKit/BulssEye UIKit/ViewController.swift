//
//  ViewController.swift
//  BulssEye UIKit
//
//  Created by Simone Tissi on 17/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startNewGame()
        
        // let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue-currentValue)
        var points = 100 - difference
        
        
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        }else if difference <= 5{
            title = "You almost had it!"
            if difference == 1 { points += 50 }
        }else if difference <= 10 {
            title="Pretty good"
        }else{
            title = "Not even close..."
        }
        
        score += points
        
        let message = "The value of the slider is: \(currentValue).\n" + "Your score in this round is: \(points)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Go to next round!", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
    @IBAction func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value=Float(currentValue)
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

