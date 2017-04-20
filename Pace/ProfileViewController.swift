//
//  ProfileViewController.swift
//  Pace
//
//  Created by Gugulethu Mhlanga on 2017/03/19.
//  Copyright © 2017 Pace. All rights reserved.
//

import UIKit 
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
	
	var profileTableView : UITableView?
	let runsCellID = "runsCellID"
	var profileHeaderView =  ProfileTabHeaderView()
	var user : User?
	var userRunsArray = [RunsModel]()
	let picker = UIImagePickerController()

	lazy var profileSetup: PaceAppServices = {
		
		let profileSetup = PaceAppServices()
		return profileSetup
		
	}()
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
	}
	
	func setupWorkoutDetailsTableView() {
		
		let tableViewFrame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
		profileTableView = UITableView(frame: tableViewFrame, style: UITableViewStyle.grouped)
		profileTableView?.backgroundColor = UIColor.black
		profileTableView?.delegate = self
		profileTableView?.dataSource = self
		profileTableView?.separatorStyle = .none
		profileTableView?.showsVerticalScrollIndicator = false
		view.addSubview(profileTableView!)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		profileTableView?.register(RunsCellView.self, forCellReuseIdentifier: runsCellID)
		self.navigationController?.navigationBar.isHidden = false
		self.navigationItem.title = "Me"
		view.backgroundColor = .black
		self.navigationBarItems()
		self.setupWorkoutDetailsTableView()
		picker.delegate = self
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
		if let userID = FIRAuth.auth()?.currentUser?.uid {
			
			self.profileSetup.observeUserRuns(userID: userID, completion: { (userRuns) in
				
				self.userRunsArray = userRuns
				
				self.profileTableView?.reloadData()
				
				
			})
			
		}
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.navigationController?.navigationBar.isHidden = false
		self.navigationItem.title = "Me"
		navigationNoLineBar()
		self.navigationBarItems()
		self.setupRightNavItems()
		self.setupHeaderView()
		self.profileTableView?.reloadData()
		
		navigationNoLineBar()
		self.navigationController?.navigationBar.barTintColor = UIColor.headerBlack()
		UIApplication.shared.statusBarView?.backgroundColor = UIColor.headerBlack()
		
	}
	
	func navigationBarItems() {
		
		let titleLabel = UILabel(frame: CGRect(x: ((view.frame.width - 100) * 0.5), y: 5, width: 100, height: view.frame.height))
		titleLabel.text = "Me"
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		textSpacing(titleLabel, spacing: 0.5)
		navigationItem.titleView = titleLabel
	
	}
	
	private func setupRightNavItems() {
		
		let composeButton = UIButton(type: .system)
		composeButton.setImage(#imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal), for: .normal)
		composeButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
		composeButton.addTarget(self, action: #selector(handleOpenSettings), for: UIControlEvents.touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: composeButton)
	
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		sizeHeaderToFit()
	}
	
	func sizeHeaderToFit() {
		
		profileHeaderView.setNeedsLayout()
		profileHeaderView.layoutIfNeeded()
		
		let height = profileHeaderView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
		var frame = profileHeaderView.frame
		frame.size.height = height
		profileHeaderView.frame = frame
	
	}
	
	func setupHeaderView() {
		
		profileHeaderView  = ProfileTabHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 380.0))
		profileHeaderView.profileVC = self
		
		if Reachability.isConnectedToNetwork() == true {
			
			self.profileHeaderView.spinner?.startAnimating()
			
			profileSetup.retrieveUser(completion: { (userFound) in
				
				if let userName  = userFound.name, let profileImageURL = userFound.profileImageUrl  {
					
					self.profileHeaderView.profileNameLabel?.text = userName
					if profileImageURL != "" {
						
						self.profileHeaderView.spinner?.stopAnimating()
						self.profileHeaderView.profileImageView?.loadImageFromUrlString(urlString: profileImageURL)
						
					} else {
						
						self.profileHeaderView.spinner?.stopAnimating()
						self.profileHeaderView.profileImageView?.image = #imageLiteral(resourceName: "profilePlaceHolder")
						
					}
					
					
				}
				
				UIApplication.shared.isNetworkActivityIndicatorVisible = false
				
			})

			
		}
		
		profileTableView?.tableHeaderView = profileHeaderView
		
	}
	
	//	Picking Image Delegates
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		
		picker.dismiss(animated: true, completion: nil)
	
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
		profileHeaderView.profileImageView?.contentMode = .scaleAspectFit
		profileHeaderView.profileImageView?.image = chosenImage
		dismiss(animated: true) {
			
			self.profileHeaderView.profileImageView?.image = nil
			self.uploadToFirebaseStorageUsingImage(imagePicked: chosenImage)
			
		}
		
	}
	
	func handleOpenSettings() {
		
		self.navigationController?.pushViewController(SettingsViewController(), animated: true)
		
	}
	
	func handleUpdateProfilePicture() {
	
		let alertController = UIAlertController(title: "Upload Profile Picture", message: nil, preferredStyle: .actionSheet)
		
		let takePhotoButton = UIAlertAction(title: "Take a photo", style: .default, handler: { (action) -> Void in
			
			if UIImagePickerController.isSourceTypeAvailable(.camera) {
				
				self.picker.allowsEditing = false
				self.picker.sourceType = UIImagePickerControllerSourceType.camera
				self.picker.cameraCaptureMode = .photo
				self.picker.modalPresentationStyle = .fullScreen
				self.present(self.picker,animated: true,completion: nil)
			
			} else {
			
				print("No Camera Found")
			
			}
			
		})
		
		let  photoLibraryButton = UIAlertAction(title: "Pick from library", style: .default, handler: { (action) -> Void in
			
			self.picker.allowsEditing = false
			self.picker.sourceType = .photoLibrary
			self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
			self.present(self.picker, animated: true, completion: nil)
		
		})
		
		let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
			
			print("Cancel button tapped")
		
		})
		
		alertController.addAction(takePhotoButton)
		alertController.addAction(photoLibraryButton)
		alertController.addAction(cancelButton)
		
		self.present(alertController, animated: true, completion: nil)
		
		
		
	}
	
	
	private func uploadToFirebaseStorageUsingImage(imagePicked: UIImage) {
		
		if Reachability.isConnectedToNetwork() == true {
			
			self.profileHeaderView.spinner?.startAnimating()
			self.profileHeaderView.profileImageView?.image = nil
			
			let imageName = NSUUID().uuidString
			let ref = FIRStorage.storage().reference().child("profileImages").child(imageName)
			
			if let uploadData = UIImageJPEGRepresentation(imagePicked, 0.5) {
				ref.put(uploadData, metadata: nil, completion: { (metadata, error) in
					
					if error != nil {
						self.failurePopup(mainMessage: "😐", detailedString: (error?.localizedDescription)!)
						self.profileHeaderView.spinner?.stopAnimating()
						self.profileHeaderView.profileImageView?.image = #imageLiteral(resourceName: "profilePlaceHolder")
						return
					}
					
					if let imageUrl = metadata?.downloadURL()?.absoluteString {
						self.updateFireBasewithProfileImage(imageCapturedURL: imageUrl, completion: { (error) in
							
							if error != nil {
								
								self.failurePopup(mainMessage: "😯", detailedString: (error?.localizedDescription)!)
								self.profileHeaderView.spinner?.stopAnimating()
								self.profileHeaderView.profileImageView?.image = #imageLiteral(resourceName: "profilePlaceHolder")
								return
							}
							
							print("Image Uploaded sucessfully")
							self.setupHeaderView()
							
							
						})
					}
					
				})
			}

			
			
		} else {
			
			self.failurePopup(mainMessage: "🙈", detailedString: "Looks like you are not connected to the Internet. Check your connection and try again. 🙃")
			
		}
		
		
	}
	
	func updateFireBasewithProfileImage(imageCapturedURL: String, completion: @escaping (_ error: Error?) -> Void ) {
		
		guard let uid =  FIRAuth.auth()?.currentUser?.uid else {
			return
		}
		
		let values = [
			"profileImageUrl": imageCapturedURL
		]
		
		FIRDatabase.database().reference().child("Users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
			
			if error != nil {
				
				completion(error)
				return
			}
			
			completion(nil)
			
		})
		
		
		
	}
	
	
}

