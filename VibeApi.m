//
//  VibeApi.m
//  VibeApi
//
//  Created by Luke on 15/06/2012.
//  Copyright (c) 2012 Luke Channings. All rights reserved.
//

#import "VibeApi.h"
#import "SocketIO.h"

@interface VibeApi ()
- (NSString *) getSubtypeFor:(NSString *) type;
- (NSString *) getSelectorForType: (NSString *) type;
@end

@implementation VibeApi
{
	BOOL isReady;
}

@synthesize _delegate, _sock;

- (id) initWithHostname: (NSString*)host andPort:(NSUInteger)port andDelegate:(id<VibeApiDelegate>)delegate{

	self = [super init];
	
	isReady = NO;
	
	_delegate = delegate;
	
	_sock= [[SocketIO alloc] initWithDelegate:(id <SocketIODelegate>)self];
	
	[_sock connectToHost:host onPort:port];
	
	return self;
}

- (void) getArtistsWithCallback:(VibeCallback)callback {

	if ( isReady ) {
		
		[_sock sendEvent:@"getArtists" withData:nil andAcknowledge:^(id argsData){
		
			NSArray *artists = [argsData objectAtIndex:1];
			
			callback(artists);
			
		}];
	}
	
	else {
	
		callback(nil);
	}
}

- (void) getArtistsInGenre:(NSString *) genre withCallback:(VibeCallback)callback {

	if ( isReady ) {
	[_sock sendEvent:@"getArtistsInGenre" withData:genre andAcknowledge:^(id argsData) {
	
		callback(argsData);
	}];
	}
	else {
	
		callback(nil);
	}
}

- (void) getAlbumsWithCallback:(VibeCallback)callback {

	if ( isReady ) {
		
		[_sock sendEvent:@"getAlbums" withData:nil andAcknowledge:^(id argsData){
			
			NSArray *albums = [argsData objectAtIndex:1];
			
			callback(albums);
			
		}];
	}
	
	else {
		
		callback(nil);
	}
}

- (void) getAlbumsByArtistWithId:(NSString *) identifier withCallback:(VibeCallback)callback {

	if ( isReady ) {
	
		[_sock sendEvent:@"getAlbumsByArtist" withData:identifier andAcknowledge:^(id data) {
		
			NSArray *albums = [data objectAtIndex:1];
			
			callback(albums);
		}];
	}
	else {
	
		callback(nil);
	}
}

- (void) getTracksWithCallback:(VibeCallback)callback {
	
	if ( isReady ) {
		
		[_sock sendEvent:@"getTracks" withData:nil andAcknowledge:^(id argsData){
			
			NSArray *tracks = [argsData objectAtIndex:1];
			
			callback(tracks);
			
		}];
	}
	
	else {
		
		callback(nil);
	}
}

- (void) getTracksInGenre:(NSString *) genre withCallback:(VibeCallback)callback {

	[_sock sendEvent:@"getTracksInGenre" withData:genre andAcknowledge:^(id data) {
	
		NSArray *tracks = [data objectAtIndex:1];
		
		callback(tracks);
	}];
}

- (void) getTracksByArtist:(NSString *) identifier withCallback:(VibeCallback)callback {
	
	if ( isReady ) {
		[_sock sendEvent:@"getTracksByArtist" withData:identifier andAcknowledge:^(id data) {
			
			NSArray *tracks = [data objectAtIndex:1];
			
			callback(tracks);
		}];
	}
	
	else {
		
		callback(nil);
	}
}

- (void) getTracksInAlbum:(NSString *) identifier withCallback:(VibeCallback)callback {
	
	if ( isReady ) {
		[_sock sendEvent:@"getTracksInAlbum" withData:identifier andAcknowledge:^(id data) {
			
			NSArray *tracks = [data objectAtIndex:1];
			
			callback(tracks);
		}];
	}
	else {
		
		callback(nil);
	}
}

- (void) getTrackWithId: (NSString *) identifier withCallback:(VibeCallback)callback {
	
	if ( isReady ) {
		[_sock sendEvent:@"getTrackWithId" withData:identifier andAcknowledge:^(id data) {
			
			NSArray *tracks = [data objectAtIndex:1];
			
			callback(tracks);
		}];
	}
	else {
		
		callback(nil);
	}
}

- (void) getGenresWithCallback:(VibeCallback)callback {
	
	if (isReady ) {
		[_sock sendEvent:@"getGenres" withData:nil andAcknowledge:^(id data) {
			
			NSArray *genre = [data objectAtIndex:1];
			
			callback(genre);
		}];
	}
	else {
		
		callback(nil);
	}
}

// SocketIO delegate methods.
- (void) socketIODidConnect:(SocketIO *)socket {

	isReady = YES;
	
	if ( [_delegate respondsToSelector:@selector(vibeApiDidConnect)] ) {
		[_delegate vibeApiDidConnect];
	}
}

- (void) socketIODidDisconnect:(SocketIO *)socket {

	isReady = NO;
	
	if ( [_delegate respondsToSelector:@selector(vibeApiDidDisconnect)] ) {
		[_delegate vibeApiDidDisconnect];
	}
}

- (NSString *) getSubtypeFor:(NSString *) type {}
- (NSString *) getSelectorForType: (NSString *) type {}

@end