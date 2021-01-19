//
//  TrackManager.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import AVFoundation

class TrackManager {
    
    // TODO: 프로퍼티 정의하기 - 트랙들, 앨범들, 오늘의 곡
    var tracks:[AVPlayerItem] = []
    var albums: [Album] = []
    var todaysTrack: AVPlayerItem?
    
    // TODO: 생성자 정의하기
    init() {
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todaysTrack = self.tracks.randomElement()
    }

    // TODO: 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        //파일들 읽어서 AVPlayerItem만들기
        //local에 있는 mp3를 모두 가져와라 그걸로 urls로 가져옴
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        //url을 가지고 AVPlayerItem을 만들었고 리턴시킴
        let items = urls.map { url in
            return AVPlayerItem(url: url)
        }
        return items
    }
    
    // TODO: 인덱스에 맞는 트랙 로드하기
    // 배열에 맞는 트랙을 가져와서 구현된 Track 클래스 프로퍼티 형태로 바꾸어주어 리턴한다.
    func track(at index: Int) -> Track? {
        let playerItem = tracks[index]
        let track = playerItem.convertToTrack()
        return track
    }

    // TODO: 앨범 로딩메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        let trackList: [Track] = tracks.compactMap{ $0.convertToTrack()}
        //가져온 트랙으로 앨범 이름으로 뭉쳐서 딕셔너리 만듦
        let albumDics = Dictionary(grouping: trackList){ (track) in track.albumName }
        var albums:[Album] = []
        for (key, value) in albumDics{
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        
        return albums
    }

    // TODO: 오늘의 트랙 랜덤으로 선책
    func loadOtherTodaysTrack() {
        //임의로 선택한다
        self.todaysTrack = self.tracks.randomElement()
    }
}
