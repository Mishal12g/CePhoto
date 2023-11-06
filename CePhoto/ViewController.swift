//
//  ViewController.swift
//  CePhoto
//
//  Created by mihail on 06.11.2023.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Privates properties
    private var imageView: UIImageView?
    
    //MARK: - Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
    }
    
    //MARK: - Privates Methods
    private func settingView() {
        view.backgroundColor = .black

        //button
        let takePhotoButton = UIButton()
        
        takePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(takePhotoButton)
        
        takePhotoButton.setTitle("Сделать фото", for: .normal)
        takePhotoButton.backgroundColor = .systemBlue
        takePhotoButton.addTarget(self, action: #selector(onTakePhoto), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            takePhotoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            takePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            takePhotoButton.heightAnchor.constraint(equalToConstant: 60),
            takePhotoButton.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        //image
        imageView = UIImageView()
        guard let image = imageView else { return }
        
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        image.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            image.bottomAnchor.constraint(equalTo: takePhotoButton.topAnchor, constant: -20),
        ])
    }
    
    @objc private func onTakePhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.cameraDevice = .rear
        picker.cameraCaptureMode = .photo
        picker.allowsEditing = true
        picker.delegate = self
        
        
        present(picker, animated: true)
    }
}

//MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage, let imageView = imageView else {
            return
        }
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }
}
