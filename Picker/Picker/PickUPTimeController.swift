//
//  PickUPTimeController.swift
//  Picker
//
//  Created by MAC193 on 6/19/18.
//  Copyright © 2018 MAC193. All rights reserved.
//

import UIKit
import MapKit

class PickUPTimeController: UIViewController {

    @IBOutlet weak var businessImageView    : UIImageView!
    @IBOutlet weak var businesNameLabel     : UILabel!
    @IBOutlet weak var businesAddressLabel  : UILabel!
    @IBOutlet weak var openingTimeLabel     : UILabel!
    
    @IBOutlet weak var todayButton          : UIButton!
    @IBOutlet weak var nextDayButton        : UIButton!
    @IBOutlet weak var thirdDayButton       : UIButton!
    
    @IBOutlet weak var datePicker           : UIDatePicker!
    @IBOutlet weak var submitButton         : UIButton!
    
    let shopTime        :   Date            =   Date();
    let interval        :   TimeInterval    =   3600;
    var weekTime        :   [WeekOpenClose] =   [WeekOpenClose]();

    var workingDate     :   [Date]          =   [Date]();
    var openTime        :   [Date]          =   [Date]();
    var closeTime       :   [Date]          =   [Date]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadWeekDate()
        self.setUIData()
        self.calculateSlot();
    }
    private func loadWeekDate(){
        let Sunday      = WeekOpenClose(dayName: "Sunday",      openTime: "00:00", closedTime: "02:00", isClosed: false)
        let Monday      = WeekOpenClose(dayName: "Monday",      openTime: "02:00", closedTime: "04:00", isClosed: false)
        let Tuesday     = WeekOpenClose(dayName: "Tuesday",     openTime: "04:00", closedTime: "06:00", isClosed: false)
        let Wednesday   = WeekOpenClose(dayName: "Wednesday",   openTime: "06:00", closedTime: "08:00", isClosed: false)
        let Thursday    = WeekOpenClose(dayName: "Thursday",    openTime: "08:00", closedTime: "10:00", isClosed: false)
        let Friday      = WeekOpenClose(dayName: "Friday",      openTime: "10:00", closedTime: "12:00", isClosed: false)
        let Saturday    = WeekOpenClose(dayName: "Saturday",    openTime: "12:00", closedTime: "14:00", isClosed: false)
        self.weekTime.append(contentsOf: [Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday]);
    }
    private func setUIData() {
        self.businesNameLabel.text      = "Tatvasoft"
        self.businesAddressLabel.text   = "Rajpath-Bopal Road, Ahmedabad, Gujarat";
        
        self.datePicker.locale = Locale(identifier: "en_US_POSIX")
        self.datePicker.addTarget(self, action: #selector(PickUPTimeController.onTapDate(_:)), for: .valueChanged)
        
        self.view.viewWithTag(1001)?.dropShadowForCell(shadowRadius: 30.0)
    }
    private func calculateSlot() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func onChangeTime( sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .long
        formatter.locale = Locale(identifier: "en_US_POSIX")
    }
    private func enabledGetDateTitle(button: UIButton, dateObject : Date) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let dayName     = NSAttributedString(string     : dateObject.dayOfWeek(date : self.shopTime)!,
                                             attributes : [NSAttributedStringKey.font               :   UIFont.systemFont(ofSize: 10),
                                                           NSAttributedStringKey.paragraphStyle     :   style,
                                                           NSAttributedStringKey.foregroundColor    :   UIColor.white])
        let dadayNumber = NSAttributedString(string     : dateObject.dayFromDate()!,
                                             attributes : [NSAttributedStringKey.font               :   UIFont.boldSystemFont(ofSize: 18),
                                                           NSAttributedStringKey.paragraphStyle     :   style,
                                                           NSAttributedStringKey.foregroundColor    :   UIColor.white])
        let finalTitle  = NSMutableAttributedString()
        finalTitle.append(dayName)
        finalTitle.append(NSAttributedString(string: "\n"))
        finalTitle.append(dadayNumber)
        
        button.dropShadowForCell(shadowRadius: 3.0)
        button.backgroundColor  = UIColor.appGreenColor();
        button.isSelected       = true;
        return finalTitle
    }
    private func disabledGetDateTitle(button: UIButton, dateObject : Date) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let dayName     = NSAttributedString(string     : dateObject.dayOfWeek(date : self.shopTime)!,
                                             attributes : [NSAttributedStringKey.font               :   UIFont.systemFont(ofSize: 10),
                                                           NSAttributedStringKey.paragraphStyle     :   style,
                                                           NSAttributedStringKey.foregroundColor    :   UIColor.appGreenColor()])
        let dadayNumber = NSAttributedString(string     : dateObject.dayFromDate()!,
                                             attributes : [NSAttributedStringKey.font               :   UIFont.boldSystemFont(ofSize: 18),
                                                           NSAttributedStringKey.paragraphStyle     :   style,
                                                           NSAttributedStringKey.foregroundColor    :   UIColor.appBlackColor373737()])
        let finalTitle  = NSMutableAttributedString()
        finalTitle.append(dayName)
        finalTitle.append(NSAttributedString(string: "\n"))
        finalTitle.append(dadayNumber)
        
        button.dropShadowForCell(shadowRadius: 3.0)
        button.backgroundColor  = UIColor.white;
        button.isSelected       = false;
        return finalTitle
    }
    @IBAction func onTapDate(_ sender: UIButton) {
        if sender == todayButton {
            todayButton.setAttributedTitle(self.enabledGetDateTitle(button: todayButton, dateObject: workingDate[0]), for: .normal)
            nextDayButton.setAttributedTitle(self.disabledGetDateTitle(button: nextDayButton, dateObject: workingDate[1]), for: .normal)
            thirdDayButton.setAttributedTitle(self.disabledGetDateTitle(button: thirdDayButton, dateObject: workingDate[2]), for: .normal)
            self.datePicker.minimumDate = self.openTime[0];
            self.datePicker.maximumDate = self.closeTime[0];
            self.datePicker.date = self.openTime[0]
        }
        else if sender == nextDayButton {
            todayButton.setAttributedTitle(self.disabledGetDateTitle(button: todayButton, dateObject: workingDate[0]), for: .normal)
            nextDayButton.setAttributedTitle(self.enabledGetDateTitle(button: nextDayButton, dateObject: workingDate[1]), for: .normal)
            thirdDayButton.setAttributedTitle(self.disabledGetDateTitle(button: thirdDayButton, dateObject: workingDate[2]), for: .normal)
            self.datePicker.minimumDate = self.openTime[1];
            self.datePicker.maximumDate = self.closeTime[1];
            self.datePicker.date = self.openTime[1]
        }
        else{
            todayButton.setAttributedTitle(self.disabledGetDateTitle(button: todayButton, dateObject: workingDate[0]), for: .normal)
            nextDayButton.setAttributedTitle(self.disabledGetDateTitle(button: nextDayButton, dateObject: workingDate[1]), for: .normal)
            thirdDayButton.setAttributedTitle(self.enabledGetDateTitle(button: thirdDayButton, dateObject: workingDate[2]), for: .normal)
            self.datePicker.minimumDate = self.openTime[2];
            self.datePicker.maximumDate = self.closeTime[2];
            self.datePicker.date = self.openTime[2]
        }
        submitButton.setTitle("Schedule: \(self.datePicker.date.dayOfWeek(date: self.shopTime)!) at \(Date.appFormaterStandard().string(from: self.datePicker.date))", for: .normal)
    }
}
