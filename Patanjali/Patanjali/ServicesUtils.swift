//
//  ServicesUtils.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import Foundation
let BaseUrl = "http://ci.thrymr.net:8055/api/v1/"
let X_API_KEY = "12e74349-eb15-4022-bc05-9330dfc369ac"
let PAYMENT_URL = "http://ci.thrymr.net:8055/"

let SESSION_EXPIRED = 101
let TRANSACTION_FAILED = 102
let PRODUCT_NOT_DELIVERABLE = 103
let DEFAULT_ADDRESS_DELETE = 104
let USER_EMAIL_REQUIRED = 105
let STOCK_NOT_AVAILABLE = 106
let INVALID_TOKEN = 107
let ACCOUNT_LOCKED = 108
let MOBILE_REQUIRED = 109
let RESPONSE_CONFLICT = 409
let ACCOUNT_BLOCKED = 110
let ACCOUNT_NOTFOUND = 404
let CANCELLED = "CANCELLED"

enum apiMethodName : Int
{
    case login
    case socialLogin
    case register_Device
    case registration
    case verifyOTP
    case resendOTP
    case verify_reset_otp
    case resend_ForgotPwd_otp
    case changePassword
    case setpassword
    case forgotPassword
    case getProfile
    case updateProfile
    case settings
    case logout
    case set_MobileNumber
    case set_Email
    
    case landingPage
    case categoryList
    case productList
    case productDetail
    case productsByCategory
    case articleList
    case articleDetail
    case wishlistCartCount
    case writeReview
    case getReviwes
    case reviewsPermission
    case productRelatedProducts
    
    case addToWishList
    case removeFromWishList
    case getWishList
    case moveToWishList
    
    case addToCart
    case updateCartItems
    case deleteFromCart
    case getCartItems
    case pinCodeDelivery
    
    case addressList
    case addAddress
    case deleteAddress
    case defaultAddress
    case updateAddress
    
    case placeOrder
    case orderTransaction
    case orderList
    case orderDetails
    case confirmOrderTransaction
    case cancelOrder
    case trackOrder
    
    case cities
    case states
    case countries
}
enum apiMethodType : Int
{
    case get
    case post
    case put
    case delete
}

