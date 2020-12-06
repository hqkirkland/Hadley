package ui;

import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedSprite;
import flixel.math.FlxPoint;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import ui.windows.WindowItem;

/**
 * ...
 * @author Hunter
 */
class WhitespaceContainer extends WindowItem
{
	public function new(width:Int, height:Int, ?relativeX:Int, ?relativeY:Int):Void
    {
        super(relativeX, relativeY, null);

        var whiteBmp:BitmapData = new BitmapData(width, height, true, 0xFFFFFFFF);
        
        for (n in 0...whiteBmp.height)
        {
            whiteBmp.setPixel32(0, n, 0xFFC0BA90);
            whiteBmp.setPixel32(whiteBmp.width - 1, n, 0xFFC0BA90);
        }

        for (n in 0...whiteBmp.width)
        {
            whiteBmp.setPixel32(n, 0, 0xFFC0BA90);
            whiteBmp.setPixel32(n, whiteBmp.height - 1, 0xFFC0BA90);
        }

        var zeroPoint:Point = new Point(0, 0);
        
        var containerTopLeft:BitmapData = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_top_left.png");
        var containerTopRight:BitmapData = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_top_right.png");
        var containerBottomLeft:BitmapData = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_bottom_left.png");
        var containerBottomRight:BitmapData = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_bottom_right.png");

        var destPoint:Point = new Point();
        var cornerRightX:Int = Std.int(whiteBmp.width - 5);
        var cornerBottomY:Int = Std.int(whiteBmp.height - 5);
        
        destPoint.x = 0;
        destPoint.y = 0;
        whiteBmp.copyPixels(containerTopLeft, containerTopLeft.rect, destPoint, null, null, true);
        whiteBmp.threshold(containerTopLeft, containerTopLeft.rect, destPoint, "==", 0xFF00FF00, 0x0);

        destPoint.x = cornerRightX;
        whiteBmp.copyPixels(containerTopRight, containerTopRight.rect, destPoint, null, null, true);
        whiteBmp.threshold(containerTopRight, containerTopRight.rect, destPoint, "==", 0xFF00FF00, 0x0);

        destPoint.y = cornerBottomY;
        whiteBmp.copyPixels(containerBottomRight, containerBottomRight.rect, destPoint, null, null, true);
        whiteBmp.threshold(containerBottomRight, containerBottomRight.rect, destPoint, "==", 0xFF00FF00, 0x0);

        destPoint.x = 0;
        whiteBmp.copyPixels(containerBottomLeft, containerBottomLeft.rect, destPoint, null, null, true);
        whiteBmp.threshold(containerBottomLeft, containerBottomLeft.rect, destPoint, "==", 0xFF00FF00, 0x0);

        this.loadGraphic(whiteBmp);
    }
}