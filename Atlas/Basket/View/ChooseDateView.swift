//
//  CalendarView.swift
//  InMaster
//
//  Created by Nurzhigit Smailov on 11/11/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//
import UIKit
import FSCalendar
class ChooseDateView: UIView {
    
    //MARK: - Properties
    var selectionAction: (Date) -> () = {date in}
    
    lazy var chooseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите дату"
        label.textColor = .black
        label.font = .getMullerBoldFont(on: 20)
        return label
    }()
    lazy var calendarView: FSCalendar = {
        let calendarView = FSCalendar()
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.appearance.todayColor = .lightGray
        calendarView.appearance.todaySelectionColor = .red
        calendarView.appearance.headerTitleColor = .mainColor
        calendarView.appearance.selectionColor = .mainColor
        calendarView.appearance.borderRadius = 5
        calendarView.appearance.weekdayTextColor = .black
        calendarView.appearance.headerDateFormat = "MMMM"
        calendarView.appearance.accessibilityLanguage = "ru-RU"
        calendarView.appearance.titleWeekendColor = .lightGray
        
        return calendarView
    }()
    lazy var chooseButton: ContinueButton = {
        let button = ContinueButton()
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 19
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    func setupViews() -> Void {
        [chooseButton, calendarView, chooseDateLabel].forEach { addSubview($0) }
        
        chooseDateLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(22)
        }
        calendarView.snp.makeConstraints { (make) in
            make.top.equalTo(chooseDateLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        chooseButton.snp.makeConstraints { (make) in
            make.top.equalTo(calendarView.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}

//MARK: - FSCalendar delegate
extension ChooseDateView: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let onePlusDay = date.add(days: 1)
        selectionAction(onePlusDay)
    }
}

extension Date {
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)!
    }
}
