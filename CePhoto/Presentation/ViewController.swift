//
//  ViewController.swift
//  CePhoto
//
//  Created by mihail on 06.11.2023.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Privates properties
    private var tableView: UITableView?
    private var photos: [UIImage] = []
    
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
        
        //Table
        tableView = UITableView()
        guard let tableView = tableView else { return }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(ImageCellTableViewCell.self, forCellReuseIdentifier: ImageCellTableViewCell.reuseIdentifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: takePhotoButton.topAnchor),
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

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageCellTableViewCell.reuseIdentifier, for: indexPath)
        guard let imageCell = cell as? ImageCellTableViewCell else {
            return   UITableViewCell()
        }
        
        imageCell.imagePoster.image = photos[indexPath.row]
        return imageCell
    }
}

//MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        photos.append(image)
        tableView?.reloadData()
    }
}
