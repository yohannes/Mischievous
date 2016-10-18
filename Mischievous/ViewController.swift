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
    var linearProgressBar: LinearProgressBar!

    // MARK: - IBAction Properties
    
    @IBAction func fartButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect("Human_Fart")
    }
    
    @IBAction func burpButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect("Male_Burps")
    }

    @IBAction func coughButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect("Male_Cough")
    }
    
    @IBAction func laughButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect("Male_Laugh")
    }
    
    @IBAction func sneezeButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect("Male_Sneeze")
    }
    
    @IBAction func cryButtonDidTouch(_ sender: UIButton) {
        self.playSoundEffect("Male_Crying")
    }
    
    // MARK: - Helper Methods
    
    fileprivate func playSoundEffect(_ fileName: String) {
        guard let validSoundFile = Bundle.main.path(forResource: fileName, ofType: "mp3"), let validSoundFileURL = URL(string: validSoundFile) else {
            return
        }
    
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: validSoundFileURL)
            self.audioPlayer?.delegate = self
            self.linearProgressBar.startAnimation()
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
      
        self.linearProgressBar = LinearProgressBar()
        self.configureLinearProgressBar()
    }
  
    // MARK: - AVAudioPlayerDelegate Methods
  
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    if flag {
      self.linearProgressBar.stopAnimation()
    }
  }
  
    // MARK: - Private Methods
  
    fileprivate func configureLinearProgressBar(){
      linearProgressBar.backgroundColor = UIColor(red:0.68, green:0.81, blue:0.72, alpha:1.0)
      linearProgressBar.progressBarColor = UIColor(red:0.26, green:0.65, blue:0.45, alpha:1.0)
      linearProgressBar.heightForLinearBar = 5
    }
}

