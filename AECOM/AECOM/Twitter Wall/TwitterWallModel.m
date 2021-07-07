//
//  TwitterWallModel.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "TwitterWallModel.h"
#import "STTwitter.h"
@implementation TwitterWallModel
@synthesize delegate;
/*!
 Getting list of tweets selected hashtag.
 */
-(void)getTweetsListAPICall
{
    [self checkDataWithDB];
    [self getTweetFeeds];
}
-(void)checkDataWithDB
{
    NSData * tweetsData = [ReusedMethods getResponseUserDefaults:DB_TWEET];
    NSData * instagramData = [ReusedMethods getResponseUserDefaults:DB_INSTAGRAM];
    if (tweetsData&&tweetsData)
    {
        NSArray *tweetsArr = [NSKeyedUnarchiver unarchiveObjectWithData:tweetsData];
        NSArray * instagram = [NSKeyedUnarchiver unarchiveObjectWithData:instagramData] ;
      feedsArray = [self mergeTwoArrays:instagram tweetArray:tweetsArr];
        [self.delegate tweetsListGetSuccessFully];
    }
    
}
-(void)getTweetFeeds
{
    STTwitterAPI *twitter1 = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"oYdZEXyuQFg7flV8HwoNQ"
                                                             consumerSecret:@"6Ndt9P4fnUZn6jD0rYKaQdI0BammQd3xTTfsGVqUOM"];
    
    [twitter1 verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        
        [self getTweetsStatically:twitter1];
   //   [twitter1 getSearchTweetsWithQuery:<#(NSString *)#> successBlock:<#^(NSDictionary *searchMetadata, NSArray *statuses)successBlock#> errorBlock:<#^(NSError *error)errorBlock#>]
        NSLog(@"Access granted with %@", bearerToken);
     /*   NSString * searchQuery = [NSString stringWithFormat:TWITTER_TAGS];
        [twitter1 getSearchTweetsWithQuery:searchQuery successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
            
           // NSLog(@"Search data : %@",searchMetadata);
        //    NSLog(@"\n\n Status : %@",statuses);i
            tweets = [[NSMutableArray alloc]init];
            for (NSMutableDictionary *dict in statuses)
            {
                // AETweetFeed * feed = [[AETweetFeed alloc] initWithJsonObject:dict];
                [tweets addObject:dict];
                //  NSLog(@"Object is %@",[dict objectForKey:@"text"]);
            }
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tweets];
            [ReusedMethods saveResponseInUserDefaults:data WithKey:DB_TWEET];
            // [self getInstagramImages];
            [self performSelector:@selector(getInstagramImages) withObject:nil withObject:nil];*/
            
        } errorBlock:^(NSError *error) {
            NSLog(@"Error : %@",error);
                        [self.delegate tweetsGettingFailed:error];
        }];
 /*       [twitter1 getUserTimelineWithScreenName:AECOM_HASHTAG successBlock:^(NSArray *statuses) {
         //   NSLog(@"-- statuses: %@", statuses);
            tweets = [[NSMutableArray alloc]init];
            for (NSMutableDictionary *dict in statuses)
            {
               // AETweetFeed * feed = [[AETweetFeed alloc] initWithJsonObject:dict];
                [tweets addObject:dict];
              //  NSLog(@"Object is %@",[dict objectForKey:@"text"]);
            }
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tweets];
            [ReusedMethods saveResponseInUserDefaults:data WithKey:DB_TWEET];
           // [self getInstagramImages];
            [self performSelector:@selector(getInstagramImages) withObject:nil withObject:nil];
        } errorBlock:^(NSError *error) {
            [self.delegate tweetsGettingFailed:error];
            NSLog(@"-- error: %@", error);
        }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"-- error %@", error);
                    [self.delegate tweetsGettingFailed:error];
    }];*/

}

-(void)getInstagramImages
{
    NSString * urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=8f8ea65c52cb41bfa9bbe4c2cad9d39b",AECOM_HASHTAG];
    
    NSURL *urlInstagram=[NSURL URLWithString:urlString];
    NSData *data=[NSData dataWithContentsOfURL:urlInstagram];
    if  (data != nil)
    {
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
   // NSLog(@"respionse %@",json);
    NSArray *instaArr=[json objectForKey:@"data"];
    NSData *instaGramData = [NSKeyedArchiver archivedDataWithRootObject:instaArr];
    [ReusedMethods saveResponseInUserDefaults:instaGramData WithKey:DB_INSTAGRAM];
    feedsArray =   [self mergeTwoArrays:[NSMutableArray arrayWithArray:instaArr] tweetArray:[NSMutableArray arrayWithArray:tweets]];
    }
    else
    {
        feedsArray = [[NSMutableArray alloc] initWithArray:tweets];
    }
    [self.delegate tweetsListGetSuccessFully];
}

-(NSMutableArray *)mergeTwoArrays:(NSMutableArray *)instagramArray tweetArray:(NSMutableArray *)tweetsArray
{
    NSMutableArray *mergeArray=[[NSMutableArray alloc] init];
    for (NSDictionary *dict in instagramArray)
    {
        NSString *timeString = [dict objectForKey:@"created_time"];
        int time=[timeString intValue];
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
        NSMutableDictionary *modifiedDict=[[NSMutableDictionary alloc] initWithDictionary:dict];
        [modifiedDict setObject:date forKey:@"TIME"];
        [modifiedDict setObject:@"INSTAGRAM" forKey:@"TWEET_TYPE"];
        [mergeArray addObject:modifiedDict];
        
    }
    
    for (NSDictionary *dict in tweetsArray)
    {
        NSString *dateString = [dict valueForKey:@"created_at"];
        
        dateString=[dateString substringFromIndex:4];
        //    NSLog(@"date string is %@",dateString);
        NSDateFormatter *datefmt=[[NSDateFormatter alloc]init];
        [datefmt setDateFormat:@"MMM dd HH:mm:ss z yyyy"];
        NSDate *date=[datefmt dateFromString:dateString];
        //  NSLog(@"date is %@",date);
        NSMutableDictionary *modifiedDict=[[NSMutableDictionary alloc] initWithDictionary:dict];
        [modifiedDict setObject:date forKey:@"TIME"];
        [modifiedDict setObject:@"TWITTER" forKey:@"TWEET_TYPE"];
        [mergeArray addObject:modifiedDict];
    }
    
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"TIME"
                                        ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
    NSArray *sortedEventArray = [mergeArray
                                 sortedArrayUsingDescriptors:sortDescriptors];
    mergeArray=[[NSMutableArray alloc] initWithArray:sortedEventArray];
    
    
    sortedEventArray =  [[sortedEventArray reverseObjectEnumerator] allObjects];
    mergeArray=[NSMutableArray arrayWithArray:sortedEventArray];
    
    
    return mergeArray;
}
#pragma mark Tableview methods
-(id)getCellDataAtIndexPath:(NSIndexPath *)indexPath
{
    return [feedsArray objectAtIndex:indexPath.row];
}

-(NSInteger )getTableviewRowsCount
{
    return [feedsArray count];  
}

-(CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    @try {
        
        NSMutableDictionary * dict  = [feedsArray objectAtIndex:indexPath.row];
        NSString *type=[dict objectForKey:@"TWEET_TYPE"];
            
            if ([type isEqualToString:@"TWITTER"])
            {
                NSString *CellIdentifier = [NSString stringWithFormat:@"CustomCell"];
                AETweetCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[AETweetCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier frameWidth:tableView.frame.size.width];
                }
                NSAttributedString * messageText =[[NSAttributedString alloc] initWithData:[[dict objectForKey:@"text"] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
                return  [cell getDescHeight:messageText.string];
            }
            else
            {
                NSString *CellIdentifier = [NSString stringWithFormat:@"Instagram_cell"];
                InstagramCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                  if (cell == nil) {
                cell = [[InstagramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier frameWidth:tableView.frame.size.width];
                  }
                NSDictionary *dict=[feedsArray objectAtIndex:indexPath.row];
                NSAttributedString * messageText =[[NSAttributedString alloc] initWithData:[[[dict objectForKey:@"caption"] objectForKey:@"text"] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
                return [cell getDescHeight:messageText.string];
            }
        
    }
    @catch (NSException *exception) {
        
        
        return 60;
    }
    return 60;
}

-(void)getTweetsStatically:(STTwitterAPI *)twitter
{
  //  NSString * urlString = @"https://api.twitter.com/1.1/search/tweets.json?count=50&include_entities=1&q=%40AECOM%20AND%20%23VR%20OR%20%23VIRTUALREALITY%20OR%20%23HYPERLOOP%20OR%20%23HYPERLOOPVR%20OR%20%23SPACEX%20OR%20%40TAMU%20OR%20%23IOT";
        NSString * urlString = @"https://api.twitter.com/1.1/search/tweets.json?q=%40AECOM%20AND%20%23VR%20OR%20%23VIRTUALREALITY%20OR%20%23HYPERLOOP%20OR%20%23HYPERLOOPVR%20OR%20%23SPACEX&count=200&include_entities=1";
    NSURL *URL = [NSURL URLWithString:urlString];
   // NSLog(@"URL %@",URL);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0];
    [urlRequest setValue:[NSString stringWithFormat:@"Bearer %@", twitter.bearerToken] forHTTPHeaderField:@"Authorization"];
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if   (data)
                               {
                                   [RBAActivityLoader removeLoader];
                                   NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   if (responseDictionary)
                                   {
                                       NSArray * statuses = [responseDictionary objectForKey:@"statuses"];
                                   tweets = [[NSMutableArray alloc]init];
                                   for (NSMutableDictionary *dict in statuses)
                                   {
                                       [tweets addObject:dict];
                                   }
                                   NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tweets];
                                   [ReusedMethods saveResponseInUserDefaults:data WithKey:DB_TWEET];
                                   // [self getInstagramImages];
                                   [self performSelector:@selector(getInstagramImages) withObject:nil withObject:nil];
                                   }
                               }
                               if (connectionError)
                               {
                                   [RBAActivityLoader removeLoader];
                                   //  NSLog(@"PNS error %@",connectionError);
                                   [self.delegate tweetsGettingFailed:connectionError];
                               }
                           }];
}
@end
