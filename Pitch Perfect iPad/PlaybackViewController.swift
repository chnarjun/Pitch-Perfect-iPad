//
//  PlaybackViewContoller.swift
//  Pitch Perfect iPad
//
//  Created by Nagarjun Chakilam on 5/28/15.
//  Copyright (c) 2015 Nagarjun Chakilam. All rights reserved.
//

import AVFoundation

import UIKit

class PlaybackViewContoller: UIViewController{
    
    var audioPlayer = AVAudioPlayer()
    
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    
    var avAudioFile: AVAudioFile!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var filePathURL = receivedAudio.filePathUrl
        audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        avAudioFile = AVAudioFile(forReading: filePathURL, error: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func snailAction(sender: UIButton) {
        
        playAudio(0.5)
        
    }
    
    @IBAction func rabitAction(sender: UIButton) {
        
        playAudio(2)
    }
    
    
    func playAudio(var rate_value:float_t){
        
        audioPlayer.stop()
        audioPlayer.rate = rate_value
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    @IBAction func chipmunkAction(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func dathVaderAction(sender: UIButton) {
        
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch_value:float_t){
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var pitchPlayer = AVAudioPlayerNode()
        
        audioEngine.attachNode(pitchPlayer)
        
        
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch_value
        
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(pitchPlayer, to: timePitch, format: nil)
        
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        
        pitchPlayer.scheduleFile(avAudioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        
        pitchPlayer.play()
        
    }
    
    @IBAction func stopPlayback(sender: UIButton) {
        
        audioPlayer.stop()
    }
}
