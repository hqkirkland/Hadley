package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:pathy30:assets%2Fdata%2FColorTable.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR0y27:assets%2Fdata%2FRoomMap.txtR2i64R3R4R5R7R6tgoR0y26:assets%2Fimages%2FBody.pngR2i11583R3y5:IMAGER5R8R6tgoR0y27:assets%2Fimages%2FDouli.pngR2i8503R3R9R5R10R6tgoR0y28:assets%2Fimages%2FDouli2.pngR2i2925R3R9R5R11R6tgoR0y26:assets%2Fimages%2FFace.pngR2i6591R3R9R5R12R6tgoR0y29:assets%2Fimages%2FGlasses.pngR2i1580R3R9R5R13R6tgoR0y26:assets%2Fimages%2FHair.pngR2i6221R3R9R5R14R6tgoR0y25:assets%2Fimages%2FHat.pngR2i9136R3R9R5R15R6tgoR0y26:assets%2Fimages%2FHat2.pngR2i2839R3R9R5R16R6tgoR0y28:assets%2Fimages%2FJacket.pngR2i7292R3R9R5R17R6tgoR0y27:assets%2Fimages%2FJeans.pngR2i4981R3R9R5R18R6tgoR0y30:assets%2Fimages%2FOvercoat.pngR2i9547R3R9R5R19R6tgoR0y27:assets%2Fimages%2FPants.pngR2i7078R3R9R5R20R6tgoR0y59:assets%2Fimages%2Frooms%2FcloudInfoRoom%2FcloudInfoRoom.pngR2i58589R3R9R5R21R6tgoR0y63:assets%2Fimages%2Frooms%2FcloudInfoRoom%2FcloudInfoRoom_map.pngR2i2424R3R9R5R22R6tgoR0y70:assets%2Fimages%2Frooms%2FcloudInfoRoom%2FcloudInfoRoom_map_MATRIX.pngR2i4162R3R9R5R23R6tgoR0y56:assets%2Fimages%2Frooms%2FcloudInfoRoom%2Fitem_door1.pngR2i1520R3R9R5R24R6tgoR0y56:assets%2Fimages%2Frooms%2FcloudInfoRoom%2Fitem_door2.pngR2i917R3R9R5R25R6tgoR0y57:assets%2Fimages%2Frooms%2FcloudInfoRoom%2Fitem_statue.pngR2i2105R3R9R5R26R6tgoR0y27:assets%2Fimages%2FShoes.pngR2i4350R3R9R5R27R6tgoR0y30:assets%2Fimages%2FTemplate.pngR2i22600R3R9R5R28R6tgoR0y18:assets%2Fintro.swfR2i890895R3y6:BINARYR5R29R6tgoR0y23:assets%2FMembership.swfR2i392540R3R30R5R31R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R32R6tgoR0y17:assets%2Fpets.swfR2i340427R3R30R5R33R6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R34R6tgoR0y18:assets%2Fvideo.swfR2i177558R3R30R5R35R6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3y9:pathGroupaR37y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R36R5y28:flixel%2Fsounds%2Fflixel.mp3R38aR40y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3y5:SOUNDR5R39R38aR37R39hgoR2i33629R3R42R5R41R38aR40R41hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R43R44y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R9R5R49R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R9R5R50R6tgh","version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_colortable_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_roommap_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_body_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_douli_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_douli2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_face_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_glasses_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hair_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hat2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_jacket_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_jeans_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_overcoat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_pants_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_cloudinforoom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_cloudinforoom_map_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_cloudinforoom_map_matrix_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_door1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_door2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_statue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shoes_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_template_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_intro_swf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_membership_swf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_pets_swf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_video_swf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/ColorTable.txt") #if display private #end class __ASSET__assets_data_colortable_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/RoomMap.txt") #if display private #end class __ASSET__assets_data_roommap_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/Body.png") #if display private #end class __ASSET__assets_images_body_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Douli.png") #if display private #end class __ASSET__assets_images_douli_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Douli2.png") #if display private #end class __ASSET__assets_images_douli2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Face.png") #if display private #end class __ASSET__assets_images_face_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Glasses.png") #if display private #end class __ASSET__assets_images_glasses_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Hair.png") #if display private #end class __ASSET__assets_images_hair_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Hat.png") #if display private #end class __ASSET__assets_images_hat_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Hat2.png") #if display private #end class __ASSET__assets_images_hat2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Jacket.png") #if display private #end class __ASSET__assets_images_jacket_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Jeans.png") #if display private #end class __ASSET__assets_images_jeans_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Overcoat.png") #if display private #end class __ASSET__assets_images_overcoat_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Pants.png") #if display private #end class __ASSET__assets_images_pants_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/cloudInfoRoom/cloudInfoRoom.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_cloudinforoom_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/cloudInfoRoom/cloudInfoRoom_map.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_cloudinforoom_map_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/cloudInfoRoom/cloudInfoRoom_map_MATRIX.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_cloudinforoom_map_matrix_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/cloudInfoRoom/item_door1.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_door1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/cloudInfoRoom/item_door2.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_door2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/cloudInfoRoom/item_statue.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_statue_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Shoes.png") #if display private #end class __ASSET__assets_images_shoes_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Template.png") #if display private #end class __ASSET__assets_images_template_png extends lime.graphics.Image {}
@:keep @:file("assets/intro.swf") #if display private #end class __ASSET__assets_intro_swf extends haxe.io.Bytes {}
@:keep @:file("assets/Membership.swf") #if display private #end class __ASSET__assets_membership_swf extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/pets.swf") #if display private #end class __ASSET__assets_pets_swf extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/video.swf") #if display private #end class __ASSET__assets_video_swf extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,4,0/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,4,0/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,4,0/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,4,0/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,4,0/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,4,0/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}


#end
#end