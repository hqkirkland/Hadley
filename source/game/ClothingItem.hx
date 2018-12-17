package game;

/**
 * @author Hunter
 */
class ClothingItem
{
	public var gameItemId:Int;
	public var itemName:String;
	public var layered:Bool;
	public var layeredAsset:String;
	public var itemType:Int;
	public var itemDesc:String;
	
	public function new(typeString:String)
	{
		switch (typeString)
		{
			case "Skin":
				itemType = 0;
			case "Hair":
				itemType = 1;
			case "Clothing":
				itemType = 2;
		}
	}
}