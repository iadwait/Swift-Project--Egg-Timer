
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
//    let softEggTime = 5
//    let MediumEggTime = 7
//    let HardEggTime = 12
    let eggTimes:[String : Int] = ["Soft":10,"Medium":420,"Hard":720]
   

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblEggStatus: UILabel!
    var totalTime = 0
    var secondsPassed = 0
    var timeLeft = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //reset
        timer.invalidate()
        totalTime = 0
        secondsPassed = 0
        progressBar.progress = 0.0
        
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        timeLeft = totalTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       
        
    }
    
    @objc func updateTimer()
    {
        if secondsPassed < totalTime {
                
            secondsPassed += 1
            let percentageProgress = (Float(secondsPassed) / Float(totalTime))
            print(percentageProgress)
            
            progressBar.progress = percentageProgress
            lblEggStatus.text = "Process Started \n Time Remaing \(timeLeft)"
            timeLeft = timeLeft - 1
        }
        else{
            timer.invalidate()
            lblEggStatus.text = "DONE!!"
            playSound()
            //progressBar.progress = 1
            
        }
    }
    
    func playSound()    {
          let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
          player = try! AVAudioPlayer(contentsOf: url!)
          player.play()
    }
}
