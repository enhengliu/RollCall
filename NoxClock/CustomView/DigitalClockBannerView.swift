//
//  DigitalClockBannerView.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/8/2.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class DigitalClockBannerView: XibView {

    @IBOutlet private var dayDisplayLabel: UILabel!
    @IBOutlet private var weekDisplayLabel: UILabel!
    @IBOutlet private var clockInDigitalClockText: DigitalClockText!
    @IBOutlet private var clockOutDigitakClockText: DigitalClockText!
    public var clockInTime: String = "00:00" {
        didSet {
            let formatter  = DateFormatter()
            formatter.dateFormat = "HH:mm"
            if let date = formatter.date(from: clockInTime) {
                let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian);
                let myComponents = myCalendar.dateComponents([.hour,.minute], from: date)
                clockInDigitalClockText.hour = myComponents.hour!;
                clockInDigitalClockText.minute = myComponents.minute!;
            }
        }
    }
    
    public var clockOutTime: String = "00:00" {
        didSet {
            let formatter  = DateFormatter()
            formatter.dateFormat = "HH:mm"
            if let date = formatter.date(from: clockOutTime) {
                let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian);
                let myComponents = myCalendar.dateComponents([.hour,.minute], from: date)
                clockOutDigitakClockText.hour = myComponents.hour!;
                clockOutDigitakClockText.minute = myComponents.minute!;
            }
        }
    }
    
    public var week: String = "星期日" {
        didSet {
            weekDisplayLabel.text = week;
        }
    }
    
    public var day: String = "01" {
        
        didSet {
            dayDisplayLabel.text = day;
        }
    }
    
    //MARK: - Life Cycle
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        self.setupUI();
    }
    
    //MARK: - Setup Method
    
    func setupUI() {
        
        self.layer.cornerRadius = self.bounds.size.height/2;
        self.layer.masksToBounds = true;
        self.nibView.layer.shadowColor = UIColor(hex: "000000").cgColor;
        self.nibView.layer.shadowOffset = CGSize(width: 7, height: 7);
        self.nibView.layer.shadowOpacity = 0.2;
        self.nibView.layer.shadowRadius = 20;
        self.clockInTime = "00:00";
        self.clockOutTime = "00:00";
    }
    
}

extension DigitalClockBannerView {
    
    public func setCurrentDate(_ currentDate:Date) {
        
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian);
        let myComponents = myCalendar.dateComponents([.weekday,.day], from: currentDate)
        switch myComponents.weekday! {
        case 1:
            week = "星期日"
            break
        case 2:
            week = "星期一"
            break
        case 3:
            week = "星期二"
            break
        case 4:
            week = "星期三"
            break
        case 5:
            week = "星期四"
            break
        case 6:
            week = "星期五"
            break
        case 7:
            week = "星期六"
            break
        default:
            week = "星期日"
            break
        }
        
        self.day = String(format: "%02d", myComponents.day!);
    }
    
    public func setClockInDate(_ currentDate:Date) {
        
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian);
        let myComponents = myCalendar.dateComponents([.hour,.minute], from: currentDate)
        let dateString = String(format: "%d:%d", myComponents.hour!,myComponents.minute!);
        self.clockInTime = dateString;
        clockInDigitalClockText.color = UIColor(hex: "E8BA81");
    }
    
    public func setClockOutDate(_ currentDate:Date) {
        
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian);
        let myComponents = myCalendar.dateComponents([.hour,.minute], from: currentDate)
        let dateString = String(format: "%d:%d", myComponents.hour!,myComponents.minute!);
        self.clockOutTime = dateString;
        clockOutDigitakClockText.color = UIColor(hex: "E8BA81");
    }
}
