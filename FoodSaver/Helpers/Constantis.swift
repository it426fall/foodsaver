//
//  Constantis.swift
//  FoodSaver
//
//  Created on 18/09/22.
//

import Foundation

enum Gender: Int, CaseIterable {
    case Male = 0
    case Female
    case Organization
    
    func displayString() -> String {
        switch self {
        case .Male:
            return NSLocalizedString("Male", comment: "Male")
        case .Female:
            return NSLocalizedString("Female", comment: "Female")
        case .Organization:
            return NSLocalizedString("Organization", comment: "Organization")
        }
    }
    
    static func valueFrom(string: String) -> Gender {
        switch string {
        case NSLocalizedString("Male", comment: "Male"):
            return .Male
        case NSLocalizedString("Female", comment: "Female"):
            return .Female
        case NSLocalizedString("Organization", comment: "Organization"):
            return .Organization
        default:
            return .Organization
        }
    }
}

enum AccountType: Int, CaseIterable {
    case Donor = 0
    case Receiver
    
    func displayString() -> String {
        switch self {
        case .Donor:
            return NSLocalizedString("Donor", comment: "Donor")
        case .Receiver:
            return NSLocalizedString("Receiver", comment: "Receiver")
        }
    }
    
    static func valueFrom(string: String) -> AccountType {
        switch string {
        case NSLocalizedString("Donor", comment: "Donor"):
            return .Donor
        case NSLocalizedString("Receiver", comment: "Receiver"):
            return .Receiver
        default:
            return .Receiver
        }
    }
}

enum AccountStatus: Int {
    case Active = 0
    case Inactive
}

enum RequestStatus: Int {
    case Requested = 0
    case Approved
    case Declined
    
    func displayString() -> String {
        switch self {
        case .Approved:
            return NSLocalizedString("Approved", comment: "Approved")
        case .Declined:
            return NSLocalizedString("Declined", comment: "Declined")
        case .Requested:
            return NSLocalizedString("Requested", comment: "Requested")
        }
    }
}

