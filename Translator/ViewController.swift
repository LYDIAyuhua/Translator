//
//  ViewController.swift
//  Translator
//
//  Created by 吴轶同 on 11/02/2017.
//  Copyright © 2017 Yitong Wu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {

    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioFile: URL!
    var audioPlayer: AVAudioPlayer!
    var rep: Int = 0
    
    //MARK: Properties
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        self.recordingSession = AVAudioSession.sharedInstance()
        self.recordingSession.requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                do{
                    try self.recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    try self.recordingSession.setActive(true)
                }
                catch{
                    self.msg.text = "Wierd...."
                }
            }
            else{
                self.msg.text = "Just say yes"
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRecording(){
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let audioFilename = documentDirectory.appendingPathComponent("recording.m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            self.audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            self.audioRecorder.delegate = self
            self.audioRecorder.record()
            self.recordButton.setTitle("Speak out Loud!", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        self.audioRecorder.stop()
        self.audioFile = self.audioRecorder.url
        self.audioRecorder = nil
        
        if success {
            self.recordButton.setTitle("Olé, Olé, Olé!", for: .normal)
        } else {
            self.recordButton.setTitle("Opps", for: .normal)
        }
    }
    
    @IBAction func onClick(_ sender: Any) {
        if self.rep == 0 {
            self.startRecording()
            self.rep += 1
        }
        else{
            self.finishRecording(success: true)
            self.rep -= 1
        }
    }
    @IBAction func play(_ sender: Any) {
        if self.audioFile != nil{
            do{
                try audioPlayer = AVAudioPlayer(contentsOf: self.audioFile)
                audioPlayer.play()
            }
            catch{}
        }
    }
    
    

    

}

