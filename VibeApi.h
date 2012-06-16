//
//  VibeApi.h
//  VibeApi
//
//  Created by Luke on 15/06/2012.
//  Copyright (c) 2012 Luke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SocketIO.h"

typedef void (^VibeCallback)(id);

@protocol VibeApiDelegate <NSObject, SocketIODelegate>
@optional
- (void) vibeApiDidConnect;
- (void) vibeApiDidDisconnect;
- (void) vibeApiDidThrowError:(NSError *) error;
@end

@interface VibeApi : NSObject
{
	id<VibeApiDelegate> _delegate;
	
	SocketIO *_sock;
}

- (id) initWithHostname: (NSString*)host andPort:(NSUInteger)port andDelegate:(id<VibeApiDelegate>)delegate;

// query methods.
- (void) getArtistsWithCallback:(VibeCallback)callback;
- (void) getArtistsInGenre:(NSString *) genre withCallback:(VibeCallback)callback;
- (void) getAlbumsWithCallback:(VibeCallback)callback;
- (void) getAlbumsByArtistWithId:(NSString *) identifier withCallback:(VibeCallback)callback;
- (void) getTracksWithCallback:(VibeCallback)callback;
- (void) getTracksInGenre:(NSString *) genre withCallback:(VibeCallback)callback;
- (void) getTracksByArtist:(NSString *) artist withCallback:(VibeCallback)callback;
- (void) getTracksInAlbum:(NSString *) identifier withCallback:(VibeCallback)callback;
- (void) getTrackWithId: (NSString *) identifier withCallback:(VibeCallback)callback;
- (void) getGenresWithCallback:(VibeCallback)callback;

@property (strong, nonatomic) id<VibeApiDelegate> _delegate;
@property (strong, nonatomic) SocketIO *_sock;
@property BOOL isReady;

@end