//
//  ViewController.swift
//  Mischievous
//
//  Created by Yohannes Wijaya on 6/25/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    // MARK: - Stored Properties
    
    var audioPlayer: AVAudioPlayer?

    var audioDuration: TimeInterval!
    
    var viewPropertyAnimator: UIViewPropertyAnimator!
    
    enum AudioAsset: String {
        case fart = "Human_Fart"
        case burps = "Male_Burps"
        case cough = "Male_Cough"
        case laugh = "Male_Laugh"
        case sneeze = "Male_Sneeze"
        case crying = "Male_Crying"
    }
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet var audioButtons: [UIButton]!
    
    // MARK: - IBAction Methods
    
    @IBAction func fartButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect(AudioAsset.fart.rawValue)
    }
    
    @IBAction func burpButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect(AudioAsset.burps.rawValue)
    }
    
    @IBAction func coughButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect(AudioAsset.cough.rawValue)
    }
    
    @IBAction func laughButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect(AudioAsset.laugh.rawValue)
    }
    
    @IBAction func sneezeButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect(AudioAsset.sneeze.rawValue)
    }
    
    @IBAction func cryButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect(AudioAsset.crying.rawValue)
    }
    
    // MARK: - Helper Methods
    
    fileprivate func playSoundEffect(_ fileName: String) {
        _ = self.audioButtons.map { (audioButton) -> Void in
            audioButton.isEnabled = false
        }
        
        guard let validSoundFile = Bundle.main.path(forResource: fileName, ofType: "mp3"), let validSoundFileURL = URL(string: validSoundFile) else {
            assertionFailure("No MP3 file found!")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: validSoundFileURL)
            self.audioPlayer?.delegate = self
            
            self.audioDuration = self.audioPlayer?.duration
            
            self.viewPropertyAnimator = UIViewPropertyAnimator(duration: self.audioDuration,
                                                               curve: .linear,
                                                               animations: { [unowned self] in
                                                                self.navigationController?.setProgress(1, animated: true)
            })
            self.viewPropertyAnimator.startAnimation()
            
            // Alternative animation implementation to UIViewPropertyAnimator
//            UIView.animate(withDuration: self.audioDuration,
//                           delay: 0,
//                           options: UIViewAnimationOptions.curveLinear,
//                           animations: { self.navigationController?.setProgress(1, animated: true) },
//                           completion: nil)
        }
        catch {
            print("there's an error initializing an instance of AVAudioPlayer")
        }
        
        self.audioPlayer?.play()
    }
    
    // MARK: - ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.audioPlayer?.prepareToPlay()
        
        self.navigationController?.progressHeight = 3
        self.navigationController?.progressTintColor = UIColor.black
    }
    
    // MARK: - AVAudioPlayerDelegate Methods
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            self.navigationController?.finishProgress()
            
            _ = self.audioButtons.map { (audioButton) -> Void in
                audioButton.isEnabled = true
            }
        }
    }
}
