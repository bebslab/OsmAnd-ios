//
//  OACommandBuilder.h
//  OsmAnd
//
//  Created by Alexey Kulish on 23/12/2017.
//  Copyright © 2017 OsmAnd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OACommandPlayer;

@interface OACommandBuilder : NSObject

- (instancetype) initWithCommandPlayer:(id<OACommandPlayer>)player;

- (OACommandBuilder *) goAhead;
- (OACommandBuilder *) goAhead:(double)dist streetName:(id)streetName;
- (OACommandBuilder *) makeUTwp;
- (OACommandBuilder *) makeUT:(id)streetName;
- (OACommandBuilder *) speedAlarm:(int)maxSpeed speed:(float)speed;
- (OACommandBuilder *) attention:(NSString *)type;
- (OACommandBuilder *) offRoute:(double)dist;
- (OACommandBuilder *) backOnRoute;
- (OACommandBuilder *) makeUT:(double)dist streetName:(id)streetName;
- (OACommandBuilder *) prepareMakeUT:(double)dist streetName:(id)streetName;
- (OACommandBuilder *) turn:(NSString *)param streetName:(id)streetName;
- (OACommandBuilder *) turn:(NSString *)param dist:(double)dist streetName:(id)streetName;

/**
 *
 * @param param A_LEFT, A_RIGHT, ...
 * @param dist
 * @return
 */
- (OACommandBuilder *) prepareTurn:(NSString *)param dist:(double)dist streetName:(id)streetName;
- (OACommandBuilder *) prepareRoundAbout:(double)dist exit:(int)exit streetName:(id)streetName;
- (OACommandBuilder *) roundAbout:(double)dist angle:(double)angle exit:(int)exit streetName:(id)streetName;
- (OACommandBuilder *) roundAbout:(double)angle exit:(int)exit streetName:(id)streetName;
- (OACommandBuilder *) andArriveAtDestination:(NSString *)name;
- (OACommandBuilder *) arrivedAtDestination:(NSString *)name;
- (OACommandBuilder *) andArriveAtIntermediatePoint:(NSString *)name;
- (OACommandBuilder *) arrivedAtIntermediatePoint:(NSString *)name;
- (OACommandBuilder *) andArriveAtWayPoint:(NSString *)name;
- (OACommandBuilder *) arrivedAtWayPoint:(NSString *)name;
- (OACommandBuilder *) andArriveAtFavorite:(NSString *)name;
- (OACommandBuilder *) arrivedAtFavorite:(NSString *)name;
- (OACommandBuilder *) andArriveAtPoi:(NSString *)name;
- (OACommandBuilder *) arrivedAtPoi:(NSString *)name;
- (OACommandBuilder *) bearLeft:(id)streetName;
- (OACommandBuilder *) bearRight:(id)streetName;
- (OACommandBuilder *) then;
- (OACommandBuilder *) gpsLocationLost;
- (OACommandBuilder *) gpsLocationRecover;
- (OACommandBuilder *) newRouteCalculated:(double)dist time:(int)time;
- (OACommandBuilder *) routeRecalculated:(double)dist time:(int)time;

- (void) play;

@end
