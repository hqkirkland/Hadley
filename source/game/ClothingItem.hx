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
	public var colorType:Int;
	public var itemType:String;
	public var itemDesc:String;
	
	public function new(_classString:String)
	{
		itemType = _classString;
		
		switch (itemType)
		{
			case "Body", "Face":
				colorType = 0;
			case "Hair":
				colorType = 1;
			case "Clothing", "Shoes", "Pants", "Shirt", "Hat", "Glasses":
				colorType = 2;
		}
	}
}