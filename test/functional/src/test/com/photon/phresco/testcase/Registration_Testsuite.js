/*
 * PHR_iphoneNativeEshopARC
 *
 * Copyright (C) 1999-2013 Photon Infotech Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#import "../../../../../main/com/photon/phresco/util/MainActivity.js"
#import "../../../../../main/com/photon/phresco/util/UIElements.js"


function Register_Test(methodName)
{
try
{
	
	
	clickOnButton(RegistrationButton);
	
    mainwindow.scrollViews()[0].textFields()[0].setValue(first);
    waitForFewSeconds(2);
	mainwindow.scrollViews()[0].textFields()[1].setValue(last);
    waitForFewSeconds(2);
	mainwindow.scrollViews()[0].textFields()[2].setValue(Email_id); 
    waitForFewSeconds(2);
	mainwindow.scrollViews()[0].secureTextFields()[0].setValue(password); 
    waitForFewSeconds(2);
	mainwindow.scrollViews()[0].secureTextFields()[1].setValue(password);
    waitForFewSeconds(2);
	
    application.keyboard().buttons()[RETURN].tap();
    waitForFewSeconds(2);
    clickOnButton(register_);
    waitForFewSeconds(2);
        
    var textValue = mainwindow.staticTexts()[labelResult].value();

    
    if (textValue === logSuccess){ 
        UIALogger.logMessage("Register Success") ;
    }
    else{
       UIALogger.logMessage("Register Fail") ;
    }
       
	clickOnButton(buttonOk);
	waitForFewSeconds(2);
    UIALogger.logPass( methodName );     
	
    
}      
catch(err)
{
            UIALogger.logMessage("There is an error") ;
            UIALogger.logFail(methodName);
            if(UIALogger.logError())
            {
               captureScreenshot("Register screenshots"); 
            }
}
  
}
Register_Test("Register_Test");

