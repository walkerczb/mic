//
//  LoginViewController.m
//  mic
//
//  Created by Zhongbo on 16/7/12.
//  Copyright © 2016年 tailong. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "QRCodeReaderViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginButtonClick:(id)sender {
    if(_nickNameTextField.text.length == 0)
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入昵称" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:NO completion:nil];
    }
    
    if(_nickNameTextField.text.length == 0)
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入手机号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:NO completion:nil];
    }
    
    QRCodeReader *codeReader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    // Instantiate the view controller
    QRCodeReaderViewController *codeReadViewController = [QRCodeReaderViewController readerWithCancelButtonTitle:@"取消" codeReader:codeReader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
    // Set the presentation style
    codeReadViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    // Define the delegate receiver
    codeReadViewController.delegate = self;
    // Or use blocks
    [codeReader setCompletionWithBlock:^(NSString *resultAsString) {
        NSLog(@"%@", resultAsString);
    }];
    
    [self presentViewController:codeReadViewController animated:YES completion:NULL];
//    UIStoryboard* mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    HomeViewController* homeViewController = [mainStroyBoard instantiateViewControllerWithIdentifier:@"homeViewController"];
//    [UIApplication sharedApplication].keyWindow.rootViewController = homeViewController;
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"autoLogin"];
}

#pragma mark - QRCodeReader Delegate Methods
//- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
//{
//    [self dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"%@", result);
//    }];
//}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
