//
//  MoreOptionsViewController.swift
//  FoodSaver
//
//  Created on 03/11/22.
//

import UIKit

enum MoreOptions: Int, CaseIterable{
    case share
    case logout
    
    func displayString() -> String {
        switch self {
        case .logout:
            return NSLocalizedString("Logout", comment: "Logout")
        case .share:
            return NSLocalizedString("Share", comment: "Share")
        }
    }
}

class MoreOptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MoreOptionsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoreOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoreOptionsTableViewCell") as?  MoreOptionsTableViewCell {
            cell.title = MoreOptions(rawValue: indexPath.row)?.displayString() ?? "-"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let opt = MoreOptions(rawValue: indexPath.row) else {
            return
        }
        
        switch opt {
        case .logout:
            AppManager.manager.loginAccount = nil
            if let login = self.storyboard?.instantiateInitialViewController() {
                UIApplication.shared.keyWindow?.rootViewController = login
            }
        case .share:
            let firstActivityItem = NSLocalizedString("Hi!, I'm using Food Server app to serve the food for the need people. Recomeding you to use the app.", comment: "Hi!, I'm using Food Server app to serve the food for the need people. Recomeding you to use the app.")

            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem], applicationActivities: nil)
            

            activityViewController.excludedActivityTypes = [
//                UIActivity.ActivityType.postToWeibo,
//                UIActivity.ActivityType.print,
//                UIActivity.ActivityType.assignToContact,
//                UIActivity.ActivityType.saveToCameraRoll,
//                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToFacebook
            ]
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}
