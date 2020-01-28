//
//  ImagePickerButton.swift
//  Amanat
//
//  Created by I on 6/26/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class ImagePickerButton: UIButton {

    var imagePickedEvent: ((_ tag: Int ,_ image: Data?) -> ())

    init(tag: Int, imagePickedEvent: @escaping ((_ tag: Int ,_ image: Data?) -> ())) {
        self.imagePickedEvent = imagePickedEvent
        super.init(frame: .zero)
        self.tag = tag
        setupBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackground() -> Void {
        backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9764705882, alpha: 1)
        setImage(#imageLiteral(resourceName: "Group 2689"), for: .normal)
        imageEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        clipsToBounds = true
        layer.borderColor = #colorLiteral(red: 0.7098039216, green: 0.7215686275, blue: 0.7921568627, alpha: 1)
        layer.borderWidth = 1

        addTarget(self, action: #selector(handleImagePickerEvent), for: .touchUpInside)
    }

    @objc func handleImagePickerEvent() -> Void {

        guard (self.backgroundImage(for: .normal) == nil) else {
            self.setBackgroundImage(nil, for: .normal)
            self.setImage(#imageLiteral(resourceName: "Group 2689"), for: .normal)
            self.imagePickedEvent(self.tag, nil)
            return
        }
        imagePicker.present(from: self)
    }

    lazy var imagePicker: ImagePicker = {

        let rootController = UIApplication.shared.keyWindow!.rootViewController!
        let imagePicker = ImagePicker(presentationController: rootController, delegate: self)

        return imagePicker
    }()
}
extension ImagePickerButton: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.setBackgroundImage(image, for: .normal)
        self.setImage(#imageLiteral(resourceName: "Group 2669"), for: .normal)
        self.imagePickedEvent(self.tag, image?.jpeg(.medium))
    }
}
