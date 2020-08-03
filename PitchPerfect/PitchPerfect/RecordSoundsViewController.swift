//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Varun Tandon on 04/02/20.
//  Copyright © 2020 Varun Tandon. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
  
  var audioRecorder: AVAudioRecorder!
  
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var recordingLabel: UILabel!
  @IBOutlet weak var stopRecordingButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    stopRecordingButton.isEnabled = false
  }
  
  @IBAction func recordAudio(_ sender: UIButton) {
    recordingLabel.text = "Recording In Progress"
    stopRecordingButton.isEnabled = true
    recordButton.isEnabled = false
    
    let dirPath = NSSearchPathForDirectoriesInDomains(
      .documentDirectory, .userDomainMask, true)[0] as String
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = URL(string: pathArray.joined(separator: "/"))
    print(filePath as Any)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSession.Category.playAndRecord,
                             mode: AVAudioSession.Mode.default,
                             options: AVAudioSession.CategoryOptions.defaultToSpeaker)
    
    try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }
  
  @IBAction func stopRecording(_ sender: Any) {
    recordButton.isEnabled = true
    stopRecordingButton.isEnabled = false
    recordingLabel.text = "Tap To Record"
    
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
  }
  
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
    } else {
      print("Recording was not successful")
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "stopRecording" {
      let playSoundsVC = segue.destination as! PlaySoundsViewController
      playSoundsVC.recordedAudioUrl = sender as? URL
    }
  }
}

