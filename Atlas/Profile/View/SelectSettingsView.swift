//
//  SelectSettingsView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/23/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class SelectSettingsView: UIView {
    
    // MARK: - Properties
    let labelBold:(String) -> UILabel = { value in
        let label = UILabel()
        label.text = value
        label.font = .getMullerBoldFont(on: 18)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        return label
    }
    lazy var logoAppImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "main")
        view.contentMode = .scaleAspectFit
        return view
    }()
    lazy var chooseLanguageTextField: UITextField = {
        let text = UITextField()
        text.isEnabled = true
        text.layer.borderWidth = 0.2
        text.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        text.layer.cornerRadius = 10
        text.isUserInteractionEnabled = true
        text.backgroundColor = UIColor(red: 0.973, green: 0.98, blue: 0.988, alpha: 1)
        return text
    }()
    lazy var soundView: SettingSwitchView = {
        let view = SettingSwitchView()
        view.textLabel.text = "Звук"
        return view
    }()
    lazy var pushView: SettingSwitchView = {
        let view = SettingSwitchView()
        view.textLabel.text = "Push уведомления"
        return view
    }()
    lazy var cityTextField: UITextField = {
        let text = UITextField()
        text.text = "Город - Алматы"
        text.layer.borderWidth = 0.2
        text.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        text.isEnabled = true
        text.layer.cornerRadius = 10
        text.isUserInteractionEnabled = false
        text.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        text.backgroundColor = UIColor(red: 0.973, green: 0.98, blue: 0.988, alpha: 1)
        return text
    }()
    lazy var thousandLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 14)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "© 2017 TOO Thousand Kazakhstan. \n rights"
        return label
    }()
    
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    let cityPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    let pushPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    let pushSecondPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        let deliveryGroupLabel = labelBold("Atlas Concorde")
        let languageLabel = labelBold("Язык")
        let pushLabel = labelBold("Звук")
        addSubviews(views: [deliveryGroupLabel, languageLabel, pushLabel])
        
        addSubviews(views: [logoAppImageView, chooseLanguageTextField, soundView,
                            pushView, cityTextField, thousandLabel])
        logoAppImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        deliveryGroupLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoAppImageView.snp.bottom).offset(16)
        }
        
//        languageLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(deliveryGroupLabel.snp.bottom).offset(16)
//            make.left.equalToSuperview().offset(16)
//        }
//        chooseLanguageTextField.snp.makeConstraints { (make) in
//            make.top.equalTo(languageLabel.snp.bottom).offset(16)
//            make.left.equalToSuperview().offset(16)
//            make.right.equalToSuperview().offset(-16)
//            make.height.equalTo(40)
//        }
//
//        chooseLanguageTextField.leftView = paddingView
//        chooseLanguageTextField.leftViewMode = .always
        
        pushLabel.snp.makeConstraints { (make) in
            make.top.equalTo(deliveryGroupLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        soundView.snp.makeConstraints { (make) in
            make.top.equalTo(pushLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }

        pushView.snp.makeConstraints { (make) in
            make.top.equalTo(soundView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    
//        cityTextField.snp.makeConstraints { (make) in
//            make.top.equalTo(pushView.snp.bottom).offset(16)
//            make.left.equalToSuperview().offset(16)
//            make.right.equalToSuperview().offset(-16)
//            make.height.equalTo(40)
//        }
//
//        cityTextField.leftView = cityPaddingView
//        cityTextField.leftViewMode = .always
        
        thousandLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pushView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.bottom.right.equalToSuperview().offset(-16)
        }
    }
}
