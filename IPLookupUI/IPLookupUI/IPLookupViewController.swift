//
//  IPLookupViewController.swift
//  IPLookupUI
//
//  Created by Oliver Eikemeier on 26.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import UIKit
import ZContainer

class IPLookupViewController: UIViewController {
    
    // MARK: Dependencies
    private let lookupService: IPLookupUIService
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        let container = ZContainer.defaultContainer()
        lookupService = container.resolve()
        
        super.init(coder: aDecoder)
    }
    
    // MARK: Outlets
    @IBOutlet weak var myIPLabel: UILabel!
    
    @IBOutlet weak var myIPButton: UIButton!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: Actions
    @IBAction func lookupIP(sender: AnyObject) {
        guard !activityIndicatorView.isAnimating() else {
            return
        }
        
        myIPLabel.text = labelTextForWaiting()
        myIPLabel.textColor = UIColor.blackColor()
        
        startLookup()
        
        lookupService.lookupIP { [weak self] (IP, error) in
            guard let this = self else {
                return
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                this.lookupHandler(IP, error: error)
            }
        }
    }
    
    // MARK: Internal methods
    
    // Handle IP lookup result
    private func lookupHandler(IP: String?, error: ErrorType?) {
        endLookup()
        
        switch (IP, error) {
        case (let IP?, nil):
            lookupSuccess(IP)
            
        case (nil, let error?):
            lookupFailure(error)
            
        default:
            assertionFailure("Expecting result or error")
        }
    }
    
    // IP Lookup successful, set Label
    private func lookupSuccess(textIP: String) {
        myIPLabel.text = labelTextForTextIP(textIP)
        storyboard
    }
    
    // IP Lookup failed, set Label
    private func lookupFailure(error: ErrorType) {
        myIPLabel.text = labelTextForError(error)
        myIPLabel.textColor = UIColor.redColor()
    }
    
    // Visually indicate activity
    private func startLookup() {
        myIPButton.enabled = false
        activityIndicatorView.startAnimating()
    }
    
    // Visually end activity
    private func endLookup() {
        activityIndicatorView.stopAnimating()
        myIPButton.enabled = true
    }
    
    // MARK: - Localization
    private lazy var localizationBundle: NSBundle = {
        let cls = IPLookupViewController.self
        return NSBundle(forClass: cls)
    }()
    
    private var localizationTable: String {
        return "IPLookup"
    }
}

extension IPLookupViewController {
    private func localizedString(string: String) -> String {
        return localizationBundle.localizedStringForKey(string, value: string, table: localizationTable)
    }
    
    private func labelTextForWaiting() -> String {
        return localizedString("Please wait")
    }
    
    private func labelTextForTextIP(textIP: String) -> String {
        let formatString = localizedString("Your IP is: %1$@")
        return String(format: formatString, textIP)
    }
    
    private func labelTextForError(error: ErrorType) -> String {
        switch error {
        case NSURLError.TimedOut:
            return localizedString("Timeout")
            
        default:
            let formatString = localizedString("An error occured: %1$@")
            let localizedDescription = (error as NSError).localizedDescription
            return String(format: formatString, localizedDescription)
        }
    }
}
