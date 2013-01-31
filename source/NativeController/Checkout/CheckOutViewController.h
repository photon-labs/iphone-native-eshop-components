//
//  CheckOutViewController.h
//  Phresco
//
//  Created by Rojaramani on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CheckoutOverAllViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class Tabbar;
@interface CheckOutViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    
    UITableView		*addToBagTable;
    
    NSMutableArray *productImageArray;
	
	NSMutableArray	*productNameArray;
    
    NSMutableIndexSet *expandedSections;
    
    UIButton *btnSaved;
    
    UIActionSheet *actionSheet;
    
    NSMutableArray *arraySaved;
    
    NSMutableArray *arrayState;
    
    NSMutableArray *statesIndia;
    
    NSMutableArray *arrayCountry;
    
    UILabel *mlabel;
    
    UIPickerView *pickerView;
    
    int mySelection;
    
    int myIndex;
    
    UITextField *txtSaved;
    
    UITextField *txtFirst;
    
    UITextField *txtLast;
    
    UITextField *txtComp;
    
    UITextField *txtAdd1;
    
    UITextField *txtAdd2;
    
    UITextField *txtCity;
    
    UITextField *txtState;
    
    UITextField *txtCountry;
    
    UITextField *txtPost;
    
    UITextField *txtPhone;
    
    UITextField *txtBillSaved;
    
    UITextField *txtBillFirst;
    
    UITextField *txtBillLast;
    
    UITextField *txtBillComp;
    
    UITextField *txtBillAdd1;
    
    UITextField *txtBillAdd2;
    
    UITextField *txtBillCity;
    
    UITextField *txtBillState;
    
    UITextField *txtBillCountry;
    
    UITextField *txtBillPost;
    
    UITextField *txtBillPhone;
    
    UIButton *chekBoxBtn;
    
    UITextView *txtOrder;
    
    NSString *checkTotalPrice;
    
    UIButton *cheqBtn;
    
    UIButton *cashBtn;
    
    Tabbar *tabbar;
    
    UIView *editView;
    
    NSString *strEmail;
    
    UITextField *txtLabel;
    
    UIView *viewController_;
    
    NSString *strInfo;
    
    NSMutableString *strConcat;
    
    NSString *countryName;
    
    
    BrowseViewController *browseViewController;
    
    SpecialOffersViewController *specialOffersViewController;
    
    CheckoutOverAllViewController *overallViewController;
    
}

@property (nonatomic, strong) UITableView	*addToBagTable;

@property (nonatomic, strong) NSMutableArray *productImageArray;

@property (nonatomic, strong) NSMutableArray	*productNameArray;

@property (nonatomic, strong)  NSMutableArray *arraySaved;

@property (nonatomic, strong)  NSMutableArray *arrayState;

@property (nonatomic, strong)  NSMutableArray *arrayCountry;

@property (nonatomic, strong)  UITextField *txtFirst;

@property (nonatomic, strong) NSString *countryName;

@property (nonatomic, strong)   NSString *checkTotalPrice;

@property (nonatomic, strong)   SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, strong)   CheckoutOverAllViewController *overallViewController;

@property (nonatomic, strong)   BrowseViewController *browseViewController;



-(void)goBack:(id)sender;

-(void) loadNavigationBar;

-(void) initializeTableView;

-(void)reviewAction:(id)sender;

-(void)cancelAction:(id)sender;

-(void) editIndex:(id)sender;

-(IBAction) savedAction:(id)sender;

-(void) stateAction:(id)sender;

-(void) countryAction:(id)sender;

-(void) dismissActionSheet:(id)sender;

-(void) chequeIndex:(id)sender;

-(void) cashIndex:(id)sender;

-(void) editButtonClicked:(id)sender;

-(void)countrySelected;


@end
