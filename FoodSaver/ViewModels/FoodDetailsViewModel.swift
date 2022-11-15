//
//  FoodDetailsViewModel.swift
//  FoodSaver
//
//  Created on 08/11/22.
//

import Foundation
import CoreLocation
import FloatRatingView


class FoodDetailsViewModel {
    let food: Food
    var reviews: Observable<[Review]> = Observable([])
    var requestQuantity: Observable<Int> = Observable(0)
    
    init(food: Food) {
        self.food = food
    }
    
    func addToFavorites(add: Bool) {
        if add {
            AppManager.manager.loginAccount?.user?.addToMyFavorites(food)
        } else {
            AppManager.manager.loginAccount?.user?.removeFromMyFavorites(food)
        }
        DBManager.manager.saveContext()
    }
    
    func addLike() {
        food.likes += 1
        DBManager.manager.saveContext()
    }
    
    func addUnlike() {
        food.dislike += 1
        DBManager.manager.saveContext()
    }
    
    func isFoodFavorite() -> Bool {
        return AppManager.manager.loginAccount?.user?.myFavorites?.contains(food) ?? false
    }
    
    func loadAllReviews() {
        reviews.value = (food.reviews?.allObjects as? [Review]) ?? []
    }
    
    func avialbleQuantity() -> Int {
        return Int(food.quantity - food.donatedQuantity)
    }
    
    func donarName() -> String {
        return (food.donar?.firstname ?? "") + " " + (food.donar?.lastname ?? "")
    }
    
    func donarPhoneNumber() -> String {
        return food.donar?.phone ?? ""
    }
    
    func donarLocation() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(food.donar?.latitude ?? 0.0, food.donar?.longitude ?? 0.0)
    }
    
    func donarAddress() -> String {
        return food.donar?.address ?? ""
    }
    
    func requestFood() -> Bool {
        guard requestQuantity.value > 0,
            let request = DBManager.manager.newEntity(entity: .Request) as? Request,
            let user = AppManager.manager.loginAccount?.user else {
            return false
        }
        
        request.date = Date()
        request.food = food
        request.quantity = Int16(requestQuantity.value)
        request.requester = user
        request.status = Int16(RequestStatus.Requested.rawValue)
        DBManager.manager.saveContext()
        return true
    }
    
    func deleteFood() -> Bool {
        guard let loginUser = AppManager.manager.loginAccount?.username,
        food.donar?.account?.username == loginUser else {
            return false
        }
        
        AppManager.manager.loginAccount?.user?.removeFromDonatedFoods(food)
        DBManager.manager.deleteEntity(entity: food)
        DBManager.manager.saveContext()
        return true
    }
}
