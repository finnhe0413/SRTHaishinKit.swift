# SRTHaishinKit
[![GitHub license](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://raw.githubusercontent.com/shogo4405/SRTHaishinKit.swift/master/LICENSE.md)

* Camera and Microphone streaming library via SRT for iOS.
* Issuesの言語は、英語か、日本語でお願いします！

## Communication
* If you need help with making LiveStreaming requests using HaishinKit, use a GitHub issue with **Bug report template**
  - The trace level log is very useful. Please set `Logboard.with(SRTHaishinKitIdentifier).level = .trace`. 
  - If you don't use an issue template. I will immediately close the your issue without a comment.
* If you'd like to discuss a feature request, use a GitHub issue with **Feature request template**.
* If you want to support e-mail based communication without GitHub issue.
  - Consulting fee is [$50](https://www.paypal.me/shogo4405/50USD)/1 incident. I'm able to response a few days.
* If you **want to contribute**, submit a pull request!

## Features
### SRT
- [x] Publish and Recording (H264/AAC)
- [ ] Playback
- [ ] mode
  - [x] caller
  - [ ] listener
  - [ ] rendezvous

see also https://github.com/shogo4405/HaishinKit.swift/blob/master/README.md

### Rendering
|-|HKView|GLHKView|MTHKView|
|-|:---:|:---:|:---:|
|Engine|AVCaptureVideoPreviewLayer|OpenGL ES|Metal|
|Publish|○|○|◯|
|VIsualEffect|×|○|◯|
|Condition|Stable|Stable|Beta|

## Requirements
|-|iOS|OSX|tvOS|XCode|Swift|CocoaPods|Carthage|
|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
|0.0.0+|8.0+|10.11+|-|10.0+|4.2|1.5.0+|0.29.0+|

## Cocoa Keys
Please contains Info.plist.

iOS 10.0+
* NSMicrophoneUsageDescription
* NSCameraUsageDescription

## License
BSD-3-Clause

## Donation
Paypal
 - https://www.paypal.me/shogo4405

Bitcoin
```txt
3FnjC3CmwFLTzNY5WPNz4LjTo1uxGNozUR
```

## Prerequisites
Make sure you setup and activate your AVAudioSession.
```swift
import AVFoundation
let session: AVAudioSession = AVAudioSession.sharedInstance()
do {
    try session.setPreferredSampleRate(44_100)
    // https://stackoverflow.com/questions/51010390/avaudiosession-setcategory-swift-4-2-ios-12-play-sound-on-silent
    if #available(iOS 10.0, *) {
        try session.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth])
    } else {
        session.perform(NSSelectorFromString("setCategory:withOptions:error:"), with: AVAudioSession.Category.playAndRecord, with:  [AVAudioSession.CategoryOptions.allowBluetooth])
    }
    try session.setMode(AVAudioSessionModeDefault)
    try session.setActive(true)
} catch {
}
```

## SRT Usage
```swift
let srtConnection: SRTConnection = SRTConnection()
let srtStream: SRTStream = SRTStream(connection: srtConnection)
srtStream.attachCamera(DeviceUtil.device(withPosition: .back))
srtStream.attachAudio(AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio))
srtStream.publish("hello")
srtConnection.connect("srt://host:port?option=foo")

var hkView: HKView = HKView(frame: view.bounds)
hkView.attachStream(srtStream)

// add ViewController#view
view.addSubview(hkView)
```

## :blue_book: FAQ
### :memo: How can I test SRT Service.
You can run the ffplay as SRT service.
```sh
ffplay -analyzeduration 100 -i 'srt://${YOUR_IP_ADDRESS}?mode=listener'
```

### :memo: How can I run example project?
SRTHaishinKit needs other dependencies. Please build.

#### Prerequisites
```sh
brew install cmake
```

#### iOS
```sh
carthage update --use-xcframeworks --platform iOS
```

## Dependencies
1. https://github.com/Haivision/srt
1. https://github.com/shogo4405/HaishinKit.swift
1. https://github.com/shogo4405/Logboard

## References
* https://www.haivision.com/products/srt-secure-reliable-transport/
