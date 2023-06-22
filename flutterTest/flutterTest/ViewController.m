//
//  ViewController.m
//  flutterTest
//
//  Created by gold on 2023/6/22.
//

#import "ViewController.h"
#import "XXFlutterViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickView)];
    [self.view addGestureRecognizer:tap];
}

- (void)onClickView{
    FlutterEngine *flutterEngine = [[FlutterEngine alloc] initWithName:@"lb_flutter"];
    [flutterEngine runWithEntrypoint:nil initialRoute:@"/"];
    XXFlutterViewController *flutterViewController = [[XXFlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [self.navigationController pushViewController:flutterViewController animated:YES];
}

@end
