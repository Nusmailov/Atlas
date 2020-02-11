//
//  CalendarViewController.swift
//  InMaster
//
//  Created by Nurzhigit Smailov on 11/11/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import FSCalendar


class CalendarViewController: ViewController {
    
    //MARK: - Properties
    lazy var dateView: ChooseDateView = {
        let view = ChooseDateView()
        view.chooseButton.addTarget(self, action: #selector(selectDate), for: .touchUpInside)
        view.selectionAction = getDate
        return view
    }()
   
    lazy var viewForDissmiss: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    var selected_Date: Date?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecognizer()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - SetupViews
    func setupViews() {
        view.addSubview(viewForDissmiss)
        view.addSubview(dateView)
        viewForDissmiss.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let locale = NSLocale(localeIdentifier: "Ru_RU")
        dateView.calendarView.locale = locale as Locale
        dateView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    //MARK: - Actions
    func setupRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.viewForDissmiss.addGestureRecognizer(gesture)
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func getDate(date: Date) {
        selected_Date = date
    }
   
    @objc func selectDate() {
        guard let date = selected_Date  else {
            showErrorMessage("")
            return
        }
        let size = self.navigationController?.viewControllers.count
        let vc = self.navigationController!.viewControllers[size! - 2] as! CheckoutViewController
        let execution_date = String(date.iso8601).prefix(10)
        vc.parameters["execution_date"] = date.iso8601
        vc.checkoutView.dateSelectView.button.setTitle("   \(execution_date)", for: .normal)
        vc.checkoutView.dateSelectView.button.setTitleColor(UIColor(red: 0.173, green: 0.184, blue: 0.2, alpha: 0.8), for: .normal)
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    func formateDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return  dateFormatter.string(from: date)
    }
}

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}
