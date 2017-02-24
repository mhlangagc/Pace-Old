//
//  LoadImageWithCache.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/02/01.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, UIImage>()
//var backgroundImageCache = NSCache<AnyObject,UIImage>()

extension UIImageView {
	
	func loadImageFromUrlString(urlString: String) {
		
		URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) in
			
			if error != nil {
				return
			}
			
			DispatchQueue.main.async {
				
				if let imageDownloaded = UIImage(data: data!) {
					
					self.image = imageDownloaded
				}
			}
			
			
		}).resume()
	}
	
	func loadImageFromCacheWithUrlString(urlString: String) {
		
		self.image = nil
		
		//check cache for image first
		if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as UIImage? {
			self.image = cachedImage
			return
		}
		
		//otherwise fire off a new download
		let url = NSURL(string: urlString)
		URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
			
			//download hit an error so lets return out
			if error != nil {
				return
			}
			
			DispatchQueue.main.async {
				
				if let downloadedImage = UIImage(data: data!) {
					imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
					
					self.image = downloadedImage
				}
			}
			
			
		}).resume()
	}
	
}
