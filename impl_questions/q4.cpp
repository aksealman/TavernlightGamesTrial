/*
 *
 * q4.cpp
 *
 * The memory leak has to do with line 4 of the script
 * player = new Player(nullptr);
 *
 * We are creating a new player object without calling delete on that object.
 *
 * The way I decided to solve is to create a newPlayerWrapper class with the constructor allocating the memory and the destructor cleaning the memory up.
 * If we use the wrapper, the player object will be freed whenever the newPlayerWrapper class goes out of scope.
 * One downside of this method is that we are calling new every time we call the addItemToPlayer function where before we would only allocate the memory if the g_game.getPlayerByName call failed.
 */
class newPlayerWrapper{
	Player* player;
public:
	newPlayerWrapper()
	{
		player = new Player(nullptr);
	}
        ~newPlayerWrapper()
	{
		delete[] player;
	}
	Player* getPlayerPtr()
	{
		return player;
        }
};
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    // This will de-allocate the memory when playerWrapper goes out of scope
    newPlayerWrapper playerWrapper;
    if (!player) {
	// This will de-allocate the memory when playerWrapper goes out of scope
        player = playerWrapper.getPlayerPtr();
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
	    // We are unable to load the recipient into the player object.
	    // Delete the player object
	    //delete[] player;
            return;
        }
     }

    Item* item = Item::CreateItem(itemId);
    // if we did not use the player wrapper we would need to delete[] the player here
    if (!item) {
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
}
