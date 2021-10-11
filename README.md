---
# Deprecated

⚠️ At WWDC Apple launched MusicKit for Swift that makes this project redundant.
See [https://developer.apple.com/videos/play/wwdc2021/10294/](https://developer.apple.com/videos/play/wwdc2021/10294/)

Big thanks to [@scottrhoyt](https://github.com/scottrhoyt) for providing this project originally.

---

# HMV
The Missing Apple Music SDK. Written in Swift.

#### SPM

Add to your `Package.swift` file like so:

```swift
import PackageDescription

let package = Package(
    name: "<YOUR_PROJECT_NAME>",
    dependencies: [
        .package(url: "https://github.com/hepto/HMV.git", from: "0.11.0")
    ]
)
```

### Usage

#### Developer Token

To use the Apple Music API, you will need to generate a developer token.
Instructions for how to do this can be found in the Apple Music API
[reference](https://developer.apple.com/library/content/documentation/NetworkingInternetWeb/Conceptual/AppleMusicWebServicesReference/SetUpWebServices.html#//apple_ref/doc/uid/TP40017625-CH2-SW1).

Once you have an Apple Music Key you can use a 3rd party library/tool to
generate your token. There is a Node.js library and CLI tool that you can find
[here](https://github.com/scottrhoyt/apple-music-jwt).

#### Create a Client

```swift
let developerToken = "<developer_token>"
let HMV = HMV(storefront: .unitedStates, developerToken: developerToken)
```

#### Search the Catalog

```swift
HMV.search(term: "Michael Jackson", types: [.albums, .songs]) { results, error in
  // Process the results or error
}
```

#### Lookup an Artist/Album/Song

```swift
let songId = "<song_id>"
HMV.song(id: songId) { result, error in
  // Process the results or error
}
```

### API Reference

The full API reference can be found [here](https://scottrhoyt.github.io/HMV).

### License

MIT
