//
// MSMenuView.m
// MSMenuView
//
// Copyright (c) 2013 Selvam Manickam (https://github.com/selvam4274)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "MSMenuView.h"

@implementation MSMenuView
@synthesize  SearchBtn,NotifyBtn,MessageBtn,FeedBackBtn,MoreBtn,delegate;


- (id)initWithFrame:(CGRect)frame
{
    CGRect frame1=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    self = [super initWithFrame:frame1];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        SearchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        SearchBtn.layer.borderWidth = 1;
        SearchBtn.layer.cornerRadius = 4;
        SearchBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        [SearchBtn setFrame:CGRectMake(3, 7, 60, 120)];
        [SearchBtn setSelected:YES];
        [SearchBtn setTag:1];
        [SearchBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [SearchBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        SearchBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 0);
        //[SearchBtn setBackgroundImage:[UIImage imageNamed:@"TabBarBG.png"] forState:UIControlStateNormal];
        //[SearchBtn setBackgroundImage:[UIImage imageNamed:@"TabBarBG.png"] forState:UIControlStateSelected];
        [SearchBtn setBackgroundColor:[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];

        [SearchBtn setTitle:@"Search" forState:UIControlStateNormal];
        [SearchBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:SearchBtn];
        
        NotifyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        NotifyBtn.layer.borderWidth = 1;
        NotifyBtn.layer.cornerRadius = 4;
        NotifyBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        [NotifyBtn setFrame:CGRectMake(66, 27, 60, 120)];
        [NotifyBtn setTag:2];
        [NotifyBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [NotifyBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        NotifyBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 0);
        //[NotifyBtn setBackgroundImage:[UIImage imageNamed:@"TabBarBG.png"] forState:UIControlStateNormal];
        //[NotifyBtn setBackgroundImage:[UIImage imageNamed:@"TabBarBG.png"] forState:UIControlStateSelected];
         [NotifyBtn setBackgroundColor:[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];
        [NotifyBtn setTitle:@"Notify" forState:UIControlStateNormal];
        [NotifyBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:NotifyBtn];

        MessageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        MessageBtn.layer.borderWidth = 1;
        MessageBtn.layer.cornerRadius = 4;
        MessageBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        [MessageBtn setFrame:CGRectMake(130, 27, 60, 120)];
        [MessageBtn setTag:3];
        [MessageBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [MessageBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        MessageBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 0);
        //[MessageBtn setBackgroundImage:[UIImage imageNamed:@"TabBarBG.png"] forState:UIControlStateNormal];
       // [MessageBtn setBackgroundImage:[UIImage imageNamed:@"TabBarBG.png"] forState:UIControlStateSelected];
        [MessageBtn setBackgroundColor:[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];
        [MessageBtn setTitle:@"Messages" forState:UIControlStateNormal];
        [MessageBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:MessageBtn];

        FeedBackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        FeedBackBtn.layer.borderWidth = 1;
        FeedBackBtn.layer.cornerRadius = 4;
        FeedBackBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        [FeedBackBtn setFrame:CGRectMake(193, 27, 60, 120)];
        [FeedBackBtn setTag:4];
        [FeedBackBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [FeedBackBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        FeedBackBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 0);
        //[FeedBackBtn setBackgroundImage:[UIImage imageNamed:@"TabBarBG.png"] forState:UIControlStateNormal];
        //[FeedBackBtn setBackgroundImage:[UIImage imageNamed:@"TabBarBG.png"] forState:UIControlStateSelected];
        [FeedBackBtn setBackgroundColor:[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];
        [FeedBackBtn setTitle:@"Feedback" forState:UIControlStateNormal];
        [FeedBackBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:FeedBackBtn];

        
        MoreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        MoreBtn.layer.borderWidth = 1;
        MoreBtn.layer.cornerRadius = 4;
        MoreBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        [MoreBtn setFrame:CGRectMake(256, 27, 60, 120)];
        [MoreBtn setTag:5];
        [MoreBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [MoreBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
         MoreBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 0);
        //[MoreBtn setBackgroundImage:[UIImage imageNamed:@"TabBarBG.png"] forState:UIControlStateNormal];
        //[MoreBtn setBackgroundImage:[UIImage imageNamed:@"TabBarBG.png"] forState:UIControlStateSelected];
         [MoreBtn setBackgroundColor:[UIColor colorWithRed:190.0/255.0f green:39.0/255.0f blue:53.0/255.0f alpha:1.0f]];
        [MoreBtn setTitle:@"More" forState:UIControlStateNormal];
        [MoreBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:MoreBtn];
        
        
        
        
    }
    
  
    return self;
    
    
}
//Need to add tag
-(void)checkSelectedBtn:(UIButton *)sender{
    int buttonTag=sender.tag;
    
    if (SearchBtn.selected && SearchBtn.tag!=buttonTag) {
        CGRect TempFrame=SearchBtn.frame;
        [UIView animateWithDuration:0.3 animations:^{
        [SearchBtn setFrame:CGRectMake(TempFrame.origin.x, TempFrame.origin.y+20, TempFrame.size.width, TempFrame.size.height)];
         }completion:^(BOOL finished) {
            
        }];
        SearchBtn.selected=NO;
            
        
    }
    else if (NotifyBtn.selected && NotifyBtn.tag!=buttonTag) {
        CGRect TempFrame=NotifyBtn.frame;
         [UIView animateWithDuration:0.3 animations:^{
        [NotifyBtn setFrame:CGRectMake(TempFrame.origin.x, TempFrame.origin.y+20, TempFrame.size.width, TempFrame.size.height)];
         }completion:^(BOOL finished) {
             
         }];
        NotifyBtn.selected=NO;
    }
   else if (MessageBtn.selected && MessageBtn.tag!=buttonTag) {
       CGRect TempFrame=MessageBtn.frame;
       [UIView animateWithDuration:0.3 animations:^{
       [MessageBtn setFrame:CGRectMake(TempFrame.origin.x, TempFrame.origin.y+20, TempFrame.size.width, TempFrame.size.height)];
       }completion:^(BOOL finished) {
           
       }];
       MessageBtn.selected=NO;
    }
   else if (FeedBackBtn.selected && FeedBackBtn.tag!=buttonTag) {
       CGRect TempFrame=FeedBackBtn.frame;
       [UIView animateWithDuration:0.3 animations:^{
       [FeedBackBtn setFrame:CGRectMake(TempFrame.origin.x, TempFrame.origin.y+20, TempFrame.size.width, TempFrame.size.height)];
       }completion:^(BOOL finished) {
           
       }];
       FeedBackBtn.selected=NO;
   }
   else if (MoreBtn.selected &&MoreBtn.tag!=buttonTag) {
       CGRect TempFrame=MoreBtn.frame;
        [UIView animateWithDuration:0.3 animations:^{
       [MoreBtn setFrame:CGRectMake(TempFrame.origin.x, TempFrame.origin.y+20, TempFrame.size.width, TempFrame.size.height)];
        }completion:^(BOOL finished) {
            
        }];
       MoreBtn.selected=NO;
   }

}
-(void)callButtonAction:(UIButton *)sender{
   // return;
    int value=sender.tag;
    if (value==1) {
        [self.delegate SearchBtnClick];
    }
    if (value==2) {
        [self.delegate NotifyBtnClick];
      }
    if (value==3) {
        [self.delegate MessageBtnClick];
    }
    if (value==4) {
        [self.delegate FeedBackBtnClick];
    }
    if (value==5) {
        [self.delegate MoreBtnClick];
     }
}

-(void)buttonClickAction:(id)sender{
        UIButton *btn=(UIButton *)sender;
        CGRect rec=btn.frame;
        if (!btn.selected) {
           [UIView animateWithDuration:0.3 animations:^{
                [btn setFrame:CGRectMake(rec.origin.x, rec.origin.y-20, rec.size.width, rec.size.height)];
           } completion:^(BOOL finished) {
               
    
            }];
            btn.selected=YES;
            [self checkSelectedBtn:btn];
            [self  callButtonAction:btn];
       }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
