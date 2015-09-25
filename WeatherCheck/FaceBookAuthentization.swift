//
//  FaceBookAuthentization.swift
//  WeatherCheck
//
//  Created by Josef Antoni on 13.09.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import Foundation

class FaceBookAuthentization {
    /*
    *   Auth the user with facebook.
    */
    /*
    func authFB(){
    let ref = Firebase(url: "https://weathercheck.firebaseio.com")
    let facebookLogin = FBSDKLoginManager()
    
    facebookLogin.logInWithReadPermissions(["email"], handler: {
    (facebookResult, facebookError) -> Void in
    
    if facebookError != nil {
    println("Facebook login failed. Error \(facebookError)")
    } else if facebookResult.isCancelled {
    println("Facebook login was cancelled.")
    } else {
    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
    
    ref.authWithOAuthProvider("facebook", token: accessToken,
    withCompletionBlock: { error, authData in
    
    if error != nil {
    println("Login failed. \(error)")
    } else {
    println("Logged in! \(authData.uid)")
    self.fbSave(authData.uid)
    
    }
    self.fbLoad()
    })
    }
    })
    
    }
    */
    /*
    * unfinished fb save values for user.
    */
    
    /*func fbSave(dataFb : NSString){
    let ref = Firebase(url: "https://weathercheck.firebaseio.com")
    var faceBookUser = ["uid": dataFb]
    var faceBookUserSettings = []
    //var gracehop = ["full_name": "Grace Hopper", "date_of_birth": "December 9, 1906"]
    
    var usersRef = ref.childByAppendingPath("users")
    
    var users = ["facebookuser": faceBookUser]
    usersRef.setValue(users)
    }*/
    
    /*
    * unfinished fb load values for user.
    */
    /*
    func fbLoad(){
    // Get a reference to our posts
    let ref = Firebase(url: "https://weathercheck.firebaseio.com")
    
    // Retrieve new posts as they are added to your database
    ref.observeEventType(.ChildAdded, withBlock: { snapshot in
    println(snapshot.value.objectForKey("facebookuser"))
    
    //println(snapshot.value.objectForKey("gracehop"))
    })
    
    // download the entire group list :(
    ref.observeSingleEventOfType(.Value, withBlock: {
    snapshot in
    var result = "is not"
    
    // iterate all the elements :((
    var children = snapshot.children
    while let child = children.nextObject() as? FDataSnapshot {
    if child.key == "uid" {
    result = "is"
    println(child.key)
    break
    }
    }
    })
    
    }
    */
}