//
//  SoundPlayer.swift
//  DevoteCoreData
//
//  Created by Gurjinder Singh on 29/01/23.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("could not find and play the sound file.")
        }
    }
}
