//
//  ViewController.m
//  XMLToPlist
//
//  Created by AugustRush on 3/30/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import "XMLReader.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pathTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)transfer:(id)sender {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"asdas" ofType:@"xml"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *read = [XMLReader dictionaryForXMLData:data error:&error];
    NSString *filePatha = [[NSBundle mainBundle] pathForResource:@"transfer" ofType:@"plist"];
    if (![read writeToFile:filePatha atomically:YES]) {
        NSLog(@"error");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
