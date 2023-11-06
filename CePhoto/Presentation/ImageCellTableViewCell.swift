//
//  ImageCellTableViewCell.swift
//  CePhoto
//
//  Created by mihail on 06.11.2023.
//

import UIKit

class ImageCellTableViewCell: UITableViewCell {
    var imagePoster = UIImageView()
    
    //MARK: - Public Properties
    static let reuseIdentifier = "ImageCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imagePoster.layer.masksToBounds = true
        imagePoster.layer.cornerRadius = 20
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Set any attributes of your UI components here.
        imagePoster.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the UI components
        contentView.addSubview(imagePoster)
        NSLayoutConstraint.activate([
            imagePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imagePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imagePoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagePoster.heightAnchor.constraint(equalTo: imagePoster.widthAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
