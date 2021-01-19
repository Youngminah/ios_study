//
//  Extension+AVPlayerItem.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import AVFoundation
import UIKit

// AVPlayerItem을 확장시켜 convert해주는 메소드를 추가해준다.
// convert는 AVPlayerItem -> Track?으로 변환해줌!!
// 익스텐션에서 stored Property는 추가 못함.
extension AVPlayerItem {
    func convertToTrack() -> Track? {
        
        //AVPlayerItem안에 asset이 있어 쓸 수 있음.
        //metadata는 타입형이 AVMetadataItem? 임.
        //그래서 이것에 관한 클래스토 확장해둠 (밑 참고)
        let metadatList = asset.metadata //곡이랑 파일안에 메타데이터라고 해서 아티스트정보, 타이틀, 섬네일 등등 데이터를 말함.
        
        var trackTitle: String?
        var trackArtist: String?
        var trackAlbumName: String?
        var trackArtwork: UIImage?
        
        for metadata in metadatList {
            if let title = metadata.title {
                trackTitle = title
            }
            
            if let artist = metadata.artist {
               trackArtist = artist
            }
            
            if let albumName = metadata.albumName {
                trackAlbumName = albumName
            }
            
            if let artwork = metadata.artwork {
                trackArtwork = artwork
            }
        }
        
        guard let title = trackTitle,
            let artist = trackArtist,
            let albumName = trackAlbumName,
            let artwork = trackArtwork else {
                return nil
        }
        return Track(title: title, artist: artist, albumName: albumName, artwork: artwork)
    }
}
 
// 메타데이타에서 여러가지 원하는 정보를 빼내기 위하여 AVMetadataItem를 확장시킨 것.
// 깔끔하게 사용하기 위하여 computed property를 따로 만든 것
extension AVMetadataItem {
    var title: String? {
        guard let key = commonKey?.rawValue, key == "title" else {
            return nil
        }
        return stringValue
    }
    
    var artist: String? {
        guard let key = commonKey?.rawValue, key == "artist" else {
            return nil
        }
        return stringValue
    }
    
    var albumName: String? {
        guard let key = commonKey?.rawValue, key == "albumName" else {
            return nil
        }
        return stringValue
    }
    
    var artwork: UIImage? {
        guard let key = commonKey?.rawValue, key == "artwork", let data = dataValue, let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}

// 플레이어가 재생중인지 아닌지?를 판단하기 위한 컴퓨티트 프로퍼티를 확장시켜 만들어주었다.
extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
