//
//  DKDetailViewController.m
//  Dusk
//
//  Created by Ke Yang on 1/19/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "DKDetailViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "RFTapEditLabel.h"

@interface DKDetailViewController () <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImage* image;
@property (weak, nonatomic) IBOutlet RFTapEditLabel *labelTitle;
@property (weak, nonatomic) IBOutlet RFTapEditLabel *labelDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
- (IBAction)onImageSelection:(id)sender;
- (IBAction)onTapGesture:(id)sender;

@end

@implementation DKDetailViewController

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
    self.labelTitle.layer.borderColor = [UIColor blackColor].CGColor;
    self.labelTitle.layer.borderWidth = 1.0;
    [self.imageView addGestureRecognizer:self.tapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onImageSelection:(id)sender {
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    break;
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                default:
                    break;
            }
        } else {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    break;
                default:
                    break;
            }
        }
        UIImagePickerController* ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        ipc.mediaTypes = @[(NSString*)kUTTypeImage];
        ipc.allowsEditing = YES;
        ipc.sourceType = sourceType;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.image = info[UIImagePickerControllerEditedImage];
    if (self.image == nil) {
        self.image = info[UIImagePickerControllerOriginalImage];
    }
    [self.imageView setImage:self.image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage*)image withName:(NSString*)imageName
{
    NSData* imageData = UIImageJPEGRepresentation(image, 0.7);
    NSString* fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
}

- (IBAction)onTapGesture:(id)sender {
    UIActionSheet* sheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc] initWithTitle:@"Choose a photo" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Take a photo", @"Choose from library", nil];
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"Choose a photo" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Choose from library", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];

}
@end
