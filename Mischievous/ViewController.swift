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
//    var soundEffectDirectoryPath: NSURL?

    // MARK: - IBAction Properties
    
    @IBAction func fartButtonDidTouch(sender: UIButton) {
//        self.playSoundEffect("Human_Fart.mp3")
        self.playSoundEffect("Human_Fart")
    }
    
    @IBAction func burpButtonDidTouch(sender: UIButton) {
        self.playSoundEffect("Male_Burps")
    }

    @IBAction func coughButtonDidTouch(sender: UIButton) {
        self.playSoundEffect("Male_Cough")
    }
    
    @IBAction func laughButtonDidTouch(sender: UIButton) {
        self.playSoundEffect("Male_Laugh")
    }
    
    @IBAction func sneezeButtonDidTouch(sender: UIButton) {
        self.playSoundEffect("Male_Sneeze")
    }
    
    @IBAction func cryButtonDidTouch(sender: UIButton) {
        self.playSoundEffect("Male_Crying")
    }
    
    // MARK: - Helper Methods
    
    private func playSoundEffect(fileName: String) {
        guard let validSoundFile = NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3"), validSoundFileURL = NSURL(string: validSoundFile) else {
            return
        }
    
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOfURL: validSoundFileURL)
        }
        catch {
            print("there's an error initializing an instance of AVAudioPlayer")
        }

        self.audioPlayer?.play()
    }
    
    // MARK: - ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.audioPlayer?.delegate = self
        self.audioPlayer?.prepareToPlay()
    }
}

