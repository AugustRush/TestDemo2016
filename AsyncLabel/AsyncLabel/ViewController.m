//
//  ViewController.m
//  AsyncLabel
//
//  Created by AugustRush on 6/16/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import "AsyncLabel.h"
#import "TextCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *texts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _texts = @[@"When the user makes a request involving your service, SiriKit sends your extension an intent object, which describes the user’s request and provides any data related to that request. You use the intent object to provide an appropriate response object, which includes details of how you can handle the user’s request. Siri typically handles all user interactions, but you can use an extension to provide custom UI that incorporates branding or additional information from your app.\nSiriKit also provides a mechanism you can use to tell the system about the interactions and activities that occur within your app.When you tell the system about these interactions, the system can determine if your app can handle the user’s current request and, if it can, pass the request to your app. In addition to the intent, SiriKit defines an interaction object, which combines an intent with information about the intent-handling process, including details such as the start time and duration of a specific occurrence of the process. If your app is registered as capable of handling an activity that has the same name as an intent, the system can launch your app with an interaction object containing that intent even if you don’t provide an Intents app extension.",@"好好的就啊就收到发货",@"423a1s32d1f98a21f6a57d9f1a32sd1f9asd1f321as9d8f46a2sd13f21a9d8sf4a2s1d32f065asdf49ad1f32a1dfa2sd13f218961a32sd1f32a4456489462189fasd16"];
    
//    self.tableView.estimatedRowHeight = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static TextCell *cell = nil;
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
    }
    cell.asyncLabel.text = self.texts[indexPath.row%3];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
    cell.asyncLabel.text = self.texts[indexPath.row%3];
    return cell;
}

@end
