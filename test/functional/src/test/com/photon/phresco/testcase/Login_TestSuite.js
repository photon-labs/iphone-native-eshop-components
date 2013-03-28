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




function Login_Test(methodName)
{
	try
		{
			clickOnButton(LoginButton);
			textFields(0, Email_id);
			passwordTextFields(0, password);	
			waitForFewSeconds(2);
			application.keyboard().buttons()[RETURN].tap();
			clickOnButton(login_);
			waitForFewSeconds(2);
			UIATarget.localTarget().logElementTree();    
    		var textValue = mainwindow.staticTexts()[logResult].value();

    
    		if (textValue === logSuccess){ 
    		     UIALogger.logMessage("Login Success") ;       			 
    			}
   			 else{
       			 UIALogger.logFail( "Login Fail" ); 
   			 }
   	 			clickOnButton(okButton);
				waitForFewSeconds(2);    
			 UIALogger.logPass( methodName );
}      
	catch(err)
			{
            UIALogger.logMessage("There is an error") ;
            UIALogger.logFail(methodName);
            if(UIALogger.logError())
            {
               captureScreenshot("Login screenshots"); 
            }
}
  
}
Login_Test("Login_Test");



