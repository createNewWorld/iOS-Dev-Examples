//
//  CustomNumberKeyboardViewController.m
//  BYAlertView
//
//  Created by 包勇 on 16/11/27.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "CustomNumberKeyboardViewController.h"

@interface CustomNumberKeyboardViewController ()


@property (nonatomic) BOOL isEditing;
@property (nonatomic,strong) NSTimer *cursorTimer;
@property (nonatomic,strong) UIView *cursorView;

@property (weak, nonatomic) IBOutlet UIView *keyboardView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation CustomNumberKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    for(UIButton * btn in self.keyboardView.subviews){
        [btn addTarget:self action:@selector(keyboardViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    //isDoingEdit draw a line
    self.inputTextField.userInteractionEnabled = NO;
    [self setEditing:YES textField:self.inputTextField];
    [self.inputTextField addTarget:self action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setEditing:NO textField:self.inputTextField];
}

- (void)keyboardViewClicked:(UIButton *)sender
{
    NSString *tmpStr = @"";
    if(self.inputTextField.text.length > 0){
        tmpStr = self.inputTextField.text;
    }
    
    if(sender.tag < 11){
        NSString *title = sender.titleLabel.text;
        tmpStr = [tmpStr stringByAppendingString:title];
    }else{
        if(sender.tag == 11){
            //删除字符
            NSInteger len = tmpStr.length;
            if(len > 0){
                tmpStr = [tmpStr substringWithRange:NSMakeRange(0, len - 1)];
            }
        }else if (sender.tag == 12){
            //结束输入
        }
    }
    
    self.inputTextField.text = tmpStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEditing:(BOOL)editing textField:(UITextField *)textField
{
    if(editing){
        //add text Observer
        [textField addObserver:self
                    forKeyPath:@"text"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
        if(!self.cursorView)
        {
            
            CGFloat offset = 6.0f;
            self.cursorView = [[UIView alloc] initWithFrame:CGRectMake(offset, 6, 2, self.inputTextField.font.pointSize + 4)];
            self.cursorView.layer.cornerRadius = 1.0f;
            self.cursorView.layer.masksToBounds = YES;
            self.cursorView.backgroundColor = [UIColor colorWithRed:(69/255.0f) green:(111/255.0f) blue:(238/255.0f) alpha:1.0f];
            [self.inputTextField addSubview:self.cursorView];
//            self.cursorView.center = CGPointMake(offset - 1, textField.center.y);
        }
        
        if(!self.cursorTimer){
            self.cursorTimer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(cursorTwinkle:) userInfo:nil repeats:YES];
        }
        
    }else{
        // view Will disappear need Remove observer
        [textField removeObserver:self forKeyPath:@"text"];
        if(self.cursorTimer.valid){
            [self.cursorTimer invalidate];
            self.cursorTimer = nil;
        }
    }
}

- (void)valueChanged:(id)sender
{
    NSLog(@"sender = %@", sender);

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"text"]){
        NSLog(@"change = %@", change);
        NSString *new = (NSString *)[change objectForKey:NSKeyValueChangeNewKey];
//        UITextField *textField = self.inputTextField;
//        UITextRange *selectedRange = [textField selectedTextRange];
//        NSInteger offset = [textField offsetFromPosition:textField.endOfDocument toPosition:selectedRange.end];
//        NSLog(@"offset = %ld", offset);
        
        CGFloat height = self.inputTextField.font.pointSize + 4;
        //NSStringDrawingUsesFontLeading
        UIFont *font = self.inputTextField.font;
        CGSize size = CGSizeMake(self.inputTextField.frame.size.width - 12, font.pointSize+4);
        CGFloat width = [new boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil].size.width;
        CGFloat offset = 6.0f + width;
        self.cursorView.frame = CGRectMake(offset, 6, 2, height);
//        self.cursorView.center = CGPointMake(offset - 1, self.inputTextField.center.y);
    }
}

- (void)cursorTwinkle:(id)sender
{
    self.cursorView.alpha = 0.0f;
    __weak typeof(self) weakSelf = self;
    CGAffineTransform transform = self.cursorView.transform;
    [UIView animateWithDuration:0.6f
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseOut)
                     animations:^{
                         
                         weakSelf.cursorView.alpha = 1.0f;
                         weakSelf.cursorView.transform = CGAffineTransformScale(transform, 1, 1.05);

                     } completion:^(BOOL finished) {
                         
                         weakSelf.cursorView.alpha = 0.0f;
                         weakSelf.cursorView.transform = CGAffineTransformIdentity;
                     }];
}

@end
