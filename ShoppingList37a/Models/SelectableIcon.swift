//
//  SelectableIcon.swift
//  ShoppingList37a
//
//  Created by Andrew Ruzavin on 16/8/26.
//

import Foundation

enum SelectableIcon: String, CaseIterable, Identifiable {
    case snow = "icSnow"
    case airplane = "icAirplane"
    case alert = "icAlert"
    case balloon = "icBalloon"
    case bandage = "icBandage"
    case barbell = "icBarbell"
    case bed = "icBed"
    case briefcase = "icBriefcase"
    case build = "icBuild"
    case business = "icBusiness"
    case calendar = "icCalendar"
    case gift = "icGift"
    case palette = "icPalette"
    case cart = "icCart"
    case car = "icCar"
    case food = "icFood"
    case paw = "icPaw"
    case controller = "icController"

    var id: String { rawValue }

    var assetName: String { rawValue }
}
