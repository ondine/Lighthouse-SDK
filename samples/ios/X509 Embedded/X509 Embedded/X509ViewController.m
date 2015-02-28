//
//  X509ViewController.m
//  X509 Embedded
//
//  Created by Jean-Max Vally on 3/21/14.
//  Copyright (c) 2014 Mocana Corp. All rights reserved.
//

#import "X509ViewController.h"
#import "MAPSDK.h"

@interface X509ViewController ()
{
    IBOutlet UITableView *certTableView;
    NSArray *certDisplayArray;
    BOOL hasValidCertificate;
}

@end

@implementation X509ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    MAP_initCertificateForDebug(@"sample", @"p12", @"secret");
    MAP_initUserForDebug(@"john-doe");
}

- (void)viewWillAppear:(BOOL)animated
{
    [self showCertificate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showCertificate
{
    // set has valid certificate to NO (guilty until proven innocent
    hasValidCertificate = NO;
    SecIdentityRef identity = MAP_getUserIdentityCertificate();
    BOOL hasCertificate = MAP_hasUserIdentityCertificate();
    NSLog(@"HAS_CERTIFICATE = %i", hasCertificate);
    NSLog(@"CERTIFICATE PTR = %p", identity);
    if (identity != NULL && hasCertificate)
    {
        hasValidCertificate = YES;
        SecCertificateRef certificate;
        SecIdentityCopyCertificate(identity, &certificate);
        
        CFStringRef summary = SecCertificateCopySubjectSummary(certificate);
        
        CFDataRef certData = SecCertificateCopyData(certificate);
        NSMutableDictionary *attributes = [[NSMutableDictionary alloc ]init];
        [attributes setValue:(__bridge NSString *)summary forKey:@"Summary"];
        [attributes setValue:(__bridge NSString *)certData forKey:@"DER"];
        
        certDisplayArray = @[
                                 @"Found certificate",
                                 [NSString stringWithFormat:@"Subject = %@", summary],
                                 [NSString stringWithFormat:@"Username = %@", MAP_getUsername()]
                                 ];
    }
    else
    {
        
        certDisplayArray = @[
                                 @"Certificate not found!"
                                 ];
    }
    [certTableView reloadData];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60; // comfortable size, allows for thumb icon view, to be shown in cell
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // only one section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return certDisplayArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FavContactCell"];
    }
    
    cell.textLabel.text = [certDisplayArray objectAtIndex:indexPath.row];
    
    // Adding thumb image, its up if we have a cert, down if we do not
    if (indexPath.row == 0)
    {
        [cell addSubview:[self cellThumbImage:hasValidCertificate]];
    }
    
    return cell;
}

#pragma mark - imageview for image thumb

- (UIImageView *)cellThumbImage:(BOOL)hasCertificate
{
    UIImageView *thumbImage = [[UIImageView alloc] initWithFrame:CGRectMake(260, 5, 50, 50)];
    thumbImage.image = [UIImage imageNamed:hasCertificate ? @"up" : @"down"];
    return thumbImage;
}


@end
