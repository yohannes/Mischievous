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
  var timer: Timer!
  var audioDuration: TimeInterval!
  
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
      
      self.audioDuration = self.audioPlayer?.duration
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.incrementProgressBar), userInfo: nil, repeats: true)
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
    self.navigationController?.progressTintColor = UIColor(red: 0, green: 0.463, blue: 1, alpha: 1)
  }
  
  // MARK: - AVAudioPlayerDelegate Methods
  
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
      if flag {
        self.navigationController?.finishProgress()
        self.timer.invalidate()
      }
    }
  
  // MARK: - Private Methods
  
  func incrementProgressBar() {
    guard let validProgress = self.navigationController?.progress else { return }
    self.navigationController?.setProgress(validProgress + Float(1 / self.audioDuration), animated: true)
  }

}

