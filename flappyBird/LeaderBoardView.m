//
//  LeaderBoardView.m
//  flappyBird
//
//  Created by ... 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "LeaderBoardView.h"
#import "CoreDataManager.h"
#import "RatingCell.h"
#import "GamerScore.h"

@interface LeaderBoardView()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end


@implementation LeaderBoardView

- (void)awakeFromNib
{
    self.dataSource = [CoreDataManager sharedManager].getRatings;
    self.infoLabel.hidden = self.dataSource.count > 0 ? YES : NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"RatingCell" bundle:nil] forCellReuseIdentifier:@"RatingCell"];
}

#pragma mark - UITableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RatingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RatingCell"];
    
    if (cell == nil) {
        cell = [[RatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RatingCell"];
    }
    
    cell.position.text = [NSString stringWithFormat:@"%ld.", (indexPath.row + 1)];
    
    GamerScore *gamerScore = self.dataSource[indexPath.row];
    
    cell.name.text = gamerScore.name;
    cell.rating.text = gamerScore.getScore;
    
    return cell;
}


- (IBAction)closeButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(leaderBoardViewProtocolCloseAction)]) {
        [self.delegate leaderBoardViewProtocolCloseAction];
    }
}

@end
