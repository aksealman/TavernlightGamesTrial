//Assume all method calls work fine. Fix the memory leak issue in the below method.
class newPlayerWrapper{
	Player * player;
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
    if (!player) {
	newPlayerWrapper playerWrapper();
	//TODO look into std::shared_ptr, or std::unique_ptr.
        //player = new Player(nullptr);
        player = playerWrapper.getPlayerPtr()
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
	    // We are unable to load the recipient into the player object.
	    // Delete the player object
	    //delete[] player;
            return;
        }
	//If we are able to load the player.
	//We should save the player so that getPlayerByName
	//returns the player object. 
     }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
}
