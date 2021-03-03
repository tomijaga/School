#include <stdio.h>
#include <stdlib.h>
#include "string.h"

#define MAX_SONGS_PER_USER 10
#define MAX_USERS 5
#define MAX_ARTISTS 100

#define NUM_TEST_USERS 7

// This struct represents a song in the system
typedef struct
{
	char *title;
	char *artist;
	short int duration;
} Song;

// This struct represents a user in the system
typedef struct
{
	char *name;
	char online;					 // 1 = YES, 0 = NO
	Song *songs[MAX_SONGS_PER_USER]; // songs this user has
	short int numSongs;				 // number of songs this user has
	short int numDownloadedSongs;
} User;

// This structure represents the Tune Share system
typedef struct
{
	User *users[MAX_USERS]; // An array of all registered users
	short int numUsers;
} TuneShare;

/* ADD ALL YOUR FUNCTIONS HERE */

int registerUser(TuneShare *t, char *name)
{
	if (t->numUsers < MAX_USERS)
	{
		User *user;
		user = (User *)malloc(sizeof(User));
		user->name = name;
		user->online = (char)0;
		user->numSongs = (short int)0;
		user->numDownloadedSongs = (short int)0;

		t->users[t->numUsers++] = user;

		return 1;
	}

	return 0;
}

int addSong(User *u, char *title, char *artist, short int duration)
{
	if (u->numSongs < MAX_SONGS_PER_USER)
	{

		Song *song = (Song *)malloc(sizeof(Song));
		song->title = title;
		song->artist = artist;
		song->duration = duration;

		u->songs[u->numSongs++] = song;

		return 1;
	}
	return 0;
}

User *userWithName(TuneShare *t, char *name)
{

	for (size_t i = 0; i < t->numUsers; i++)
	{
		if (strcmp(t->users[i]->name, name) == 0)
		{
			return t->users[i];
		}
	}

	return NULL;
}

short int numOfOnlineUsers(TuneShare *t)
{
	short int num = 0;
	for (size_t i = 0; i < t->numUsers; i++)
	{
		if (t->users[i]->online == 1)
		{
			num += 1;
		}
	}

	return num;
}

short int numOfAvailableSongs(TuneShare *t)
{
	short int num = 0;
	for (size_t i = 0; i < t->numUsers; i++)
	{
		if (t->users[i]->online == 1)
		{
			num = num + t->users[i]->numSongs;
		}
	}

	return num;
}

User **onlineUsers(TuneShare *t, short int *numOnLine)
{
	User **users;

	*numOnLine = numOfOnlineUsers(t);
	users = (User **)malloc(sizeof(User *) * (short int)numOnLine);

	if (users == NULL)
		return 0;

	// short int userCount = 0;
	// for (size_t i = 0; i < (short int)numOnLine; i++)
	// {
	// 	if (t->users[i]->online == 1)
	// 	{
	// 		if (userCount < (short int)numOnLine)
	// 		{
	// 			users[userCount++] = t->users[i];
	// 		}
	// 	}
	// }
	printf("%lu", sizeof(users));
	return users;
}

Song **allAvailableSongs(TuneShare *t, short int *numSongs)
{
	Song **songs = NULL;
	*numSongs = numOfAvailableSongs(t);

	short int songsCount = 0;
	songs = (Song **)malloc(sizeof(Song *) * (short int)numSongs);

	if (songs == NULL)
	{
		return NULL;
	}

	for (size_t i = 0; i < t->numUsers; i++)
	{
		if (t->users[i]->online == 1)
		{
			for (size_t j = 0; j < t->users[i]->numSongs; i++)
			{
				if (songsCount < (short int)numSongs)
				{
					songs[songsCount++] = t->users[i]->songs[j];
				}
			}
		}
	}

	return songs;
}

void printTab()
{
	printf("\t");
}

void printSong(Song *song)
{
	printTab();
	printTab();
	printf("\"%s\" by %s\n", song->title, song->artist);
}

void printUser(User *user)
{
	printTab();
	printf("%s with %d songs as follows:\n", user->name, user->numSongs);

	for (size_t i = 0; i < user->numSongs; i++)
	{
		printSong(user->songs[i]);
	}
}

void logon(TuneShare *t, char *name)
{
	User *user = userWithName(t, name);

	if (user != NULL)
	{
		user->online = 1;
		short int numOnline = numOfOnlineUsers(t);
		short int numAvail = numOfAvailableSongs(t);

		printf("logging in %s\n", user->name);
		printf("num of Online Users %d\n", numOnline);
		User **users = onlineUsers(t, &numOnline);

		// printUser(users[0]);
		printf("num of availableSongs Users %d\n", numAvail);
	}
}

void logoff(TuneShare *t, char *name)
{
	User *user = userWithName(t, name);

	if (user != NULL)
	{
		user->online = 0;

		short int numOnline = numOfOnlineUsers(t);
		short int numAvail = numOfAvailableSongs(t);
		printf("logging off %s\n", user->name);
		printf("num of Online Users %d\n", numOnline);
		User **online_users = onlineUsers(t, &numOnline);

		printUser(online_users[0]);
		printf("num of availableSongs Users %d\n", numAvail);
	}
}

// void displayStats(TuneShare *t)
// {
// 	short int *numOnlineUsers;
// 	User **online_users = onlineUsers(t, numOnlineUsers);

// 	short int *numOfAvailableSongs;
// 	Song **availableSongs = allAvailableSongs(t, numOfAvailableSongs);

// 	printf("\nTune Share Center (%d registered user)\n", t->numUsers);

// 	if (availableSongs == NULL)
// 		return;
// 	printf("\t%d Online Users:\n", *numOnlineUsers);

// 	for (size_t i = 0; i < *numOnlineUsers; i++)
// 	{
// 		printUser(online_users[i]);
// 	}

// 	printf("\t%d Available Songs:\n", *numOfAvailableSongs);
// 	for (size_t i = 0; i < *numOfAvailableSongs; i++)
// 	{
// 		printSong(availableSongs[i]);
// 	}
// }

// void displayAvailableSongsByArtist(TuneShare *t, char *artist)
// {
// 	short int *numOfAvailableSongs;
// 	Song **availableSongs = allAvailableSongs(t, numOfAvailableSongs);

// 	for (size_t i = 0; i < (int)numOfAvailableSongs; i++)
// 	{
// 		if (strcmp((*availableSongs)[i].artist, artist) == 0)
// 		{
// 			printSong(availableSongs[i]);
// 		}
// 	}
// }

// Song *getSong(TuneShare *t, char *title, char *ownerName)
// {
// 	User *user = userWithName(t, ownerName);
// 	if (user != NULL)
// 	{
// 		if (user->online == 1)
// 		{
// 			for (size_t i = 0; i < user->numSongs; i++)
// 			{
// 				if (strcmp(user->songs[i]->title, title))
// 				{
// 					return user->songs[i];
// 				}
// 			}
// 		}
// 	}
// 	return NULL;
// }

// void downloadSong(TuneShare *t, char *downloadToName, char *title, char *downloadFromName)
// {
// 	Song *song = getSong(t, title, downloadFromName);

// 	if (song != NULL)
// 	{
// 		User *user = userWithName(t, downloadToName);
// 		if (user != NULL && user->online == 1)
// 		{
// 			int check = addSong(user, song->title, song->artist, song->duration);
// 			if (check == 1)
// 			{
// 				User *userOfDownloadedSong = userWithName(t, downloadFromName);
// 				if (userOfDownloadedSong != NULL)
// 				{
// 					userOfDownloadedSong->numDownloadedSongs += 1;
// 				}
// 			}
// 		}
// 	}
// }

// void printRoyalties(User *user)
// {
// 	if (user->numDownloadedSongs > 0)
// 	{
// 		float royalty = 0.25f * user->numDownloadedSongs;
// 		printf("$%2.2f %s", royalty, user->name);
// 	}
// }

// void displayRoyalties(TuneShare *t)
// {
// 	for (size_t i = 0; i < t->numUsers; i++)
// 	{
// 		printRoyalties(t->users[i]);
// 	}
// }

// void freeUser(User *user)
// {
// 	for (size_t i = 0; i < user->numSongs; i++)
// 	{
// 		free(user->songs[i]);
// 	}
// 	free(user);
// }

// void shutDown(TuneShare *t)
// {
// 	for (size_t i = 0; i < t->numUsers; i++)
// 	{
// 		freeUser(t->users[i]);
// 	}
// }

// DO NOT MODIFY THE MAIN FUNCTION
int main()
{
	// This is test data
	static char *TITLES[] = {
		"Back 2 Life",
		"Loneliness For Love",
		"Desire 126",
		"Perfect",
		"In My Head",
		"Old Skool Love",
		"Let's Go",
		"No Place",
		"We Gotta Go",
		"How You Get the Girl",
		"Catch",
		"Here Tonight",
		"Details",
		"Dangerous",
		"Brighter Than the Sun",
		"Photograph",
		"Thinking Out Loud",
		"If Heaven Were to Fall",
		"I Just Wanna Be With You",
		"Song Sung Blue",
		"Outta Style",
		"Why",
	};

	static char *ARTISTS[] = {
		"E-Type",
		"Lovely the Band",
		"Hollerado",
		"Ed Sheeran",
		"Ryland James",
		"Divine Brown",
		"Group 1 Crew",
		"Backstreet Boys",
		"E-Type",
		"Taylor Swift",
		"Brett Young",
		"Brett Young",
		"Billy Currington",
		"Kardinal Offichall",
		"Colbie Caillat",
		"Ed Sheeran",
		"Ed Sheeran",
		"E-Type",
		"E-Type",
		"Neil Diamond",
		"Aaron Watson",
		"Frankie Avalon",
	};

	static int DURATIONS[] = {217, 237, 187, 263, 205, 204, 256, 179, 213, 247, 196,
							  216, 201, 251, 231, 202, 281, 223, 230, 185, 222, 161};

	static char *TEST_USER_NAMES[NUM_TEST_USERS] = {"Disco Stew", "Peter Punk", "Country Candy", "Ronnie Rocker",
													"Sleeping Sam", "Disco Stew", "Mellow Marvin"};

	static int LIST_SIZES[NUM_TEST_USERS] = {7, 9, 9, 5, 1, 0, 0};
	static int SONGNUMS[NUM_TEST_USERS][MAX_SONGS_PER_USER] = {
		{1, 2, 4, 5, 12, 15, 21}, {0, 1, 3, 8, 9, 13, 14, 17, 20}, {6, 7, 8, 10, 11, 12, 13, 20, 21}, {0, 8, 16, 17, 18}, {19}, {}, {}};

	// Create the TuneShare Center
	TuneShare tuneShareCenter;
	tuneShareCenter.numUsers = 0;

	// Attempt to register all test users
	for (int i = 0; i < NUM_TEST_USERS; i++)
	{
		if (!registerUser(&tuneShareCenter, TEST_USER_NAMES[i]))
			printf("Error adding User: \"%s\"\n", TEST_USER_NAMES[i]);
		else
			printf("User: \"%s\" has been registered\n", TEST_USER_NAMES[i]);
	}

	// // Display some stats
	// displayStats(&tuneShareCenter);

	// Log on a user
	printf("\nLogging on a user...\n");
	logon(&tuneShareCenter, "Disco Stew");

	// // Display some stats
	// displayStats(&tuneShareCenter);

	// Now add all the test songs for these test users
	for (int i = 0; i < tuneShareCenter.numUsers; i++)
	{
		for (int j = 0; j < LIST_SIZES[i]; j++)
			addSong(tuneShareCenter.users[i], TITLES[SONGNUMS[i][j]], ARTISTS[SONGNUMS[i][j]], DURATIONS[SONGNUMS[i][j]]);
	}

	// Display some stats
	// displayStats(&tuneShareCenter);

	// // Display all songs by E-Type
	// printf("Available Songs By E-Type: \n");
	// displayAvailableSongsByArtist(&tuneShareCenter, "E-Type");

	// Now bring two more users online
	printf("\nLogging on three users...\n");
	logon(&tuneShareCenter, "Disco Stew");	  // Already logged on ... does nothing
	logon(&tuneShareCenter, "Mellow Marvin"); // Won't Work
	logon(&tuneShareCenter, "Peter Punk");
	logon(&tuneShareCenter, "Country Candy");

	// // Display some stats again
	// displayStats(&tuneShareCenter);

	// // Log the last two users online
	// printf("\nLogging on two more users...\n");
	// logon(&tuneShareCenter, "Ronnie Rocker");
	// logon(&tuneShareCenter, "Sleeping Sam");

	// // Display some stats again
	// displayStats(&tuneShareCenter);

	// // Display all songs by E-Type
	// printf("Available Songs By E-Type: \n");
	// displayAvailableSongsByArtist(&tuneShareCenter, "E-Type");

	// // Log off a couple of users
	// printf("\nLogging off some users...\n");
	// logoff(&tuneShareCenter, "Country Candy");
	// logoff(&tuneShareCenter, "Mellow Marvin"); // Won't work
	// logoff(&tuneShareCenter, "Peter Punk");

	// // Display some stats again
	// displayStats(&tuneShareCenter);

	// // Display all songs by E-Type
	// printf("Available Songs By E-Type: \n");
	// displayAvailableSongsByArtist(&tuneShareCenter, "E-Type");

	// // Have Sleeping Sam download some songs from other online users
	// printf("\nSleeping Sam downloading 2 songs from Disco Stew and 2 from Ronnie Rocker...\n");
	// downloadSong(&tuneShareCenter, "Sleeping Sam", "Old Skool Love", "Disco Stew");
	// downloadSong(&tuneShareCenter, "Sleeping Sam", "In My Head", "Disco Stew");
	// downloadSong(&tuneShareCenter, "Sleeping Sam", "If Heaven Were to Fall", "Ronnie Rocker");
	// downloadSong(&tuneShareCenter, "Sleeping Sam", "I Just Wanna Be With You", "Ronnie Rocker");
	// downloadSong(&tuneShareCenter, "Sleeping Sam", "We Gotta Go", "Country Candy");

	// // Have Ronnie Rocker download from Sleeping Sam and Disco Stew
	// printf("\nRonnie Rocker downloading a songs from Sleeping Sam and a song from Disco Stew...\n");
	// downloadSong(&tuneShareCenter, "Ronnie Rocker", "Song Sung Blue", "Sleeping Sam");
	// downloadSong(&tuneShareCenter, "Ronnie Rocker", "Desire 126", "Disco Stew");

	// // None of these should work
	// downloadSong(&tuneShareCenter, "Sleeping Sam", "Back 2 Life", "Disco Stew");		// Won't work ... not a song of his
	// downloadSong(&tuneShareCenter, "Sleeping Sam", "No Place", "Mellow Marvin");		// Won't work, not a user
	// downloadSong(&tuneShareCenter, "Mellow Marvin", "Song Sung Blue", "Sleeping Sam");	// Won't work, not registered user
	// downloadSong(&tuneShareCenter, "Ronnie Rocker", "Song Sung Blue", "Mellow Marvin"); // Won't work, not registered user
	// downloadSong(&tuneShareCenter, "Country Candy", "Song Sung Blue", "Sleeping Sam");	// Won't work, not logged on
	// downloadSong(&tuneShareCenter, "Sleeping Song", "Popsicles", "Ronnie Rocker");		// Won't work, song doesn't exist

	// // Log on Country Candy and have her download a song from Ronnie
	// printf("\nLogging on Country Candy...\n");
	// logon(&tuneShareCenter, "Country Candy");
	// downloadSong(&tuneShareCenter, "Country Candy", "Song Sung Blue", "Ronnie Rocker");

	// // Display some stats again
	// displayStats(&tuneShareCenter);

	// // Log off the last few users
	// printf("\nLogging off three more users...\n");
	// logoff(&tuneShareCenter, "Disco Stew");
	// logoff(&tuneShareCenter, "Ronnie Rocker");
	// logoff(&tuneShareCenter, "Sleeping Sam");
	// logoff(&tuneShareCenter, "Sleeping Sam"); // Won't Work now

	// // Display some stats again
	// displayStats(&tuneShareCenter);

	// // Display all songs by E-Type
	// printf("Available Songs By E-Type: \n");
	// displayAvailableSongsByArtist(&tuneShareCenter, "E-Type");

	// // Now display the royalties for all downloaded songs at 25 cents per song
	// printf("\nHere are the royalties to be paid:\n");
	// displayRoyalties(&tuneShareCenter);

	// // Shut down the Tune Share center
	// shutDown(&tuneShareCenter);
}
