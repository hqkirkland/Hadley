package ui;
import game.ClientData;
import game.ClothingItem;

/**
 * ...
 * @author Hunter
 */
class StoreWindow extends Window
{
	private var itemArray:Array<ClothingItem>;
	private var slotArray:Array<SlotBox>;
	
	public function new() 
	{
		super("Shop", 250, 200);
		
		itemArray = new Array<ClothingItem>();
		slotArray = new Array<SlotBox>();
	}
	
	public function setUpItems(itemSet:Array<Int>)
	{
		var n:Int = 0;
		
		for (itemNum in itemSet)
		{
			if (ClientData.clothingItems.exists(itemNum))
			{				
				var box:SlotBox = new SlotBox(ClientData.clothingItems[itemNum].itemType);
				box.setGameItem(itemNum, 1);
				slotArray.push(box);
				
				box.x = this.x;
				box.y = (n * box.height) + 5;
				
				n++;
			}
		}
	}
}