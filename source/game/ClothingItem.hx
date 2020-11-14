package game;

/**
 * @author Hunter
 */
class ClothingItem
{
	public var gameItemId:Int;
	public var setId:Int;
	public var itemName:String;
	public var layered:Bool;
	public var layeredAsset:String;
	public var colorType:Int;
	public var itemType:String;
	public var itemDesc:String;
	
	public function new(_classString:String)
	{
		itemType = _classString;
		colorType = GraphicsSheet.itemTypeToColorType(itemType);
	}
}