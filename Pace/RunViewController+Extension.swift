//
//  ReadyViewController+Extension.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/04/18.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

extension RunViewController {
	
	//  MARK: Music Actions
	func registerMediaPlayerNotifications() {
		
		//let notificationCenter: NotificationCenter = NotificationCenter.default
		
		//notification
		
		//notificationCenter.addObserver(self, selector: #selector(handle_NowPlayingItemChanged), name: MPMusicPlayerControllerNowPlayingItemDidChange as NSNotification.Name, object: musicPlayer)
		
		//notificationCenter.addObserver(self, selector: #selector(handle_PlaybackStateChanged), name: MPMusicPlayerControllerPlaybackStateDidChange as NSNotification.Name, object: musicPlayer)
		
		
		//musicPlayer.beginGeneratingPlaybackNotifications()
		
		let notificationCenter: NotificationCenter = NotificationCenter.default
		
		notificationCenter.addObserver(self, selector: #selector(handle_NowPlayingItemChanged),
		                               name: NSNotification.Name(rawValue: "MPMusicPlayerControllerNowPlayingItemDidChangeNotification"),
		                               object: musicPlayer)
		
		notificationCenter.addObserver(self, selector: #selector(handle_PlaybackStateChanged),
		                               name: NSNotification.Name(rawValue: "MPMusicPlayerControllerPlaybackStateDidChangeNotification"),
		                               object: musicPlayer)
		
		musicPlayer.beginGeneratingPlaybackNotifications()
		
	}
	
	
	func handle_NowPlayingItemChanged(){
		
		let playBackState: MPMusicPlaybackState = musicPlayer.playbackState
		
		if playBackState == MPMusicPlaybackState.paused {
			
			musicPlayerView?.playButton.setImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
			
			
		} else if musicPlayer.playbackState == MPMusicPlaybackState.playing {
			
			musicPlayerView?.playButton.setImage(#imageLiteral(resourceName: "Pause"), for: UIControlState.normal)
			
		} else if musicPlayer.playbackState == MPMusicPlaybackState.stopped{
			
			musicPlayerView?.playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
			musicPlayer.stop()
		}
		
		
	}
	
	func handle_PlaybackStateChanged() {
		
		
		if musicPlayer.nowPlayingItem == nil {
			
			
			//  Pause or Play the track
			musicPlayerView?.playButton.setImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
			
			
		} else {
			
			if let currentItem: MPMediaItem = musicPlayer.nowPlayingItem {
				
				//  Artwork
				if let artwork: MPMediaItemArtwork = currentItem.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork {
					
					let artworkImage = artwork.image(at: CGSize(width: 60.0, height: 60.0))
					musicPlayerView?.musicButton.setImage(artworkImage, for: UIControlState.normal)
					
					
				} else {
					
					musicPlayerView?.musicButton.setImage(#imageLiteral(resourceName: "cover"), for: UIControlState.normal)
					
				}
				
				
				
				//  Title & Artist
				if let titleString: String = currentItem.value(forProperty: MPMediaItemPropertyTitle) as? String {
					
					musicPlayerView?.songPlayingLabel.text = titleString
					
				} else {
					
					musicPlayerView?.songPlayingLabel.text = "Uknown Song"
					
				}
				
				
			}
			
			//playPauseButton.setImage(UIImage(named:  "play"), for: UIControlState.normal)
			
		}
		
		
		
	}
	
	
	//  MARK: Actions
	func selectMusic() {
		
		perform(#selector(openMediaView), with: nil, afterDelay: 0.25)
		
		
	}
	
	func openMediaView() {
		
		let mediaPicker: MPMediaPickerController = MPMediaPickerController(mediaTypes: .music)
		mediaPicker.delegate = self
		mediaPicker.allowsPickingMultipleItems = true
		mediaPicker.showsCloudItems = true
		mediaPicker.prompt = "Select an Album,Playlist or Song"
		self.present(mediaPicker, animated: true, completion: nil)
		
	}
	
	func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
		
		musicPlayer.setQueue(with: mediaItemCollection)
		musicPlayer.play()
		
		self.dismiss(animated: true, completion: nil)
		
	}
	
	
	func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
	
		mediaPicker.dismiss(animated: true, completion: nil)
	
	}
	
	
	func Pause() {
		
		if musicPlayer.nowPlayingItem != nil {
			
			//Pause or Play the track
			if self.musicPlayer.playbackState == MPMusicPlaybackState.playing {
				
				self.musicPlayer.pause()
				musicPlayerView?.playButton.setImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
				
			} else {
				
				
				self.musicPlayer.play()
				musicPlayerView?.playButton.setImage(#imageLiteral(resourceName: "Pause"), for: UIControlState.normal)
				
			}
			
			
		} else {
			
			//self.selectMusic()
			
			
		}
		
		
	}
	
	func Forward() {
		
		//buttonBounceAnimation(buttonPressed: forwardButton!)
		//buttonBounceAnimation(buttonPressed: musicButton!)
		
		if musicPlayer.nowPlayingItem != nil {
			
			self.musicPlayer.skipToNextItem()
			self.handle_PlaybackStateChanged()
			
		}
		
	}

}
