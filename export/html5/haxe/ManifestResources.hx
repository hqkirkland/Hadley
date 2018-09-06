package;


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
	
	
	public static function init (config:Dynamic):Void {
		
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
		
		#if kha
		
		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);
		
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");
		
		#else
		
		data = '{"name":null,"assets":"aoy8:positionzy4:sizezy4:typey5:IMAGEy2:idy51:assets%2FcloudInfoRoom%2Fimages%2FcloudInfoRoom.pngy6:lengthi58589y7:preloadtgoR0i58589R1zR2R3R4y55:assets%2FcloudInfoRoom%2Fimages%2FcloudInfoRoom_map.pngR6i2781R7tgoR0i61370R1zR2R3R4y48:assets%2FcloudInfoRoom%2Fimages%2Fitem_door1.pngR6i1520R7tgoR0i62890R1zR2R3R4y48:assets%2FcloudInfoRoom%2Fimages%2Fitem_door2.pngR6i891R7tgoR0i63781R1zR2R3R4y49:assets%2FcloudInfoRoom%2Fimages%2Fitem_statue.pngR6i2105R7tgoR0i65886R1zR2R3R4y58:assets%2FcloudInfoRoom%2Fimages%2Fitem_statue_animated.pngR6i3213R7tgoR0i69099R1zR2y4:TEXTR4y33:assets%2FcloudInfoRoom%2FNPC.jsonR6zgoR0i69099R1zR2R13R4y41:assets%2FcloudInfoRoom%2FRoomObjects.jsonR6i319goR0i69418R1zR2R13R4y36:assets%2FcloudInfoRoom%2FSounds.jsonR6zgh","rootPath":null,"version":2,"libraryArgs":["lib/cloudInfoRoom.pak","pak"],"libraryType":"lime.utils.PackedAssetLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("cloudInfoRoom", library);
		data = '{"name":null,"assets":"aoy4:pathy26:assets%2Fimages%2FBody.pngy4:sizei11583y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y27:assets%2Fimages%2FDouli.pngR2i8503R3R4R5R7R6tgoR0y28:assets%2Fimages%2FDouli2.pngR2i2925R3R4R5R8R6tgoR0y26:assets%2Fimages%2FFace.pngR2i6591R3R4R5R9R6tgoR0y29:assets%2Fimages%2FGlasses.pngR2i1580R3R4R5R10R6tgoR0y26:assets%2Fimages%2FHair.pngR2i6221R3R4R5R11R6tgoR0y25:assets%2Fimages%2FHat.pngR2i9136R3R4R5R12R6tgoR0y26:assets%2Fimages%2FHat2.pngR2i2839R3R4R5R13R6tgoR0y28:assets%2Fimages%2FJacket.pngR2i7292R3R4R5R14R6tgoR0y27:assets%2Fimages%2FJeans.pngR2i4981R3R4R5R15R6tgoR0y30:assets%2Fimages%2FOvercoat.pngR2i9547R3R4R5R16R6tgoR0y27:assets%2Fimages%2FPants.pngR2i7078R3R4R5R17R6tgoR0y61:assets%2Fimages%2Frooms%2FcloudInfoRoom%2FcloudInfoRoom_A.pngR2i58589R3R4R5R18R6tgoR0y65:assets%2Fimages%2Frooms%2FcloudInfoRoom%2FcloudInfoRoom_map_A.pngR2i2781R3R4R5R19R6tgoR0y58:assets%2Fimages%2Frooms%2FcloudInfoRoom%2Fitem_door1_A.pngR2i1520R3R4R5R20R6tgoR0y58:assets%2Fimages%2Frooms%2FcloudInfoRoom%2Fitem_door2_A.pngR2i891R3R4R5R21R6tgoR0y59:assets%2Fimages%2Frooms%2FcloudInfoRoom%2Fitem_statue_A.pngR2i2105R3R4R5R22R6tgoR0y27:assets%2Fimages%2FShoes.pngR2i4350R3R4R5R23R6tgoR0y30:assets%2Fimages%2FTemplate.pngR2i22600R3R4R5R24R6tgoR2i121186R3y5:SOUNDR5y27:assets%2Fsounds%2FStep1.wavy9:pathGroupaR26hR6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3R27aR29y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R28R5y28:flixel%2Fsounds%2Fflixel.mp3R27aR31y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R25R5R30R27aR29R30hgoR2i33629R3R25R5R32R27aR31R32hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R33R34y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R4R5R39R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R4R5R40R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
		#end
		
	}
	
	
}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_cloudinforoom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_cloudinforoom_map_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_item_door1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_item_door2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_item_statue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_item_statue_animated_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_npc_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_roomobjects_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_sounds_json extends null { }
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
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_cloudinforoom_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_cloudinforoom_map_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_door1_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_door2_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_statue_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shoes_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_template_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_step1_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__lib_cloudinforoom_pak extends null { }
@:keep @:bind #if display private #end class __ASSET__manifest_cloudinforoom_json extends null { }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

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
@:keep @:image("assets/images/rooms/cloudInfoRoom/cloudInfoRoom_A.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_cloudinforoom_a_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/cloudInfoRoom/cloudInfoRoom_map_A.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_cloudinforoom_map_a_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/cloudInfoRoom/item_door1_A.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_door1_a_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/cloudInfoRoom/item_door2_A.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_door2_a_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/cloudInfoRoom/item_statue_A.png") #if display private #end class __ASSET__assets_images_rooms_cloudinforoom_item_statue_a_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Shoes.png") #if display private #end class __ASSET__assets_images_shoes_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Template.png") #if display private #end class __ASSET__assets_images_template_png extends lime.graphics.Image {}
@:keep @:file("assets/sounds/Step1.wav") #if display private #end class __ASSET__assets_sounds_step1_wav extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("export/html5/obj/libraries/cloudInfoRoom.pak") #if display private #end class __ASSET__lib_cloudinforoom_pak extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_cloudinforoom_json extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end