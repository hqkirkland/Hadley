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
		
		data = '{"name":null,"assets":"aoy4:sizei593y4:typey4:TEXTy9:classNamey56:__ASSET__assets_cloudinforoom_cloudinforoom_objects_jsony2:idy51:assets%2FcloudInfoRoom%2FcloudInfoRoom_Objects.jsongoR0i58589R1y5:IMAGER3y54:__ASSET__assets_cloudinforoom_images_cloudinforoom_pngR5y51:assets%2FcloudInfoRoom%2Fimages%2FcloudInfoRoom.pnggoR0i2485R1R7R3y58:__ASSET__assets_cloudinforoom_images_cloudinforoom_map_pngR5y55:assets%2FcloudInfoRoom%2Fimages%2FcloudInfoRoom_map.pnggoR0i1520R1R7R3y51:__ASSET__assets_cloudinforoom_images_item_door1_pngR5y48:assets%2FcloudInfoRoom%2Fimages%2Fitem_door1.pnggoR0i891R1R7R3y51:__ASSET__assets_cloudinforoom_images_item_door2_pngR5y48:assets%2FcloudInfoRoom%2Fimages%2Fitem_door2.pnggoR0i2105R1R7R3y52:__ASSET__assets_cloudinforoom_images_item_statue_pngR5y49:assets%2FcloudInfoRoom%2Fimages%2Fitem_statue.pnggoR0i304R1R7R3y51:__ASSET__assets_cloudinforoom_images_portal_1_a_pngR5y48:assets%2FcloudInfoRoom%2Fimages%2Fportal_1_a.pnggh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("cloudInfoRoom", library);
		data = '{"name":null,"assets":"aoy4:sizei517y4:typey4:TEXTy9:classNamey48:__ASSET__assets_cloudlift_cloudlift_objects_jsony2:idy43:assets%2FcloudLift%2FcloudLift_Objects.jsongoR0i128940R1y5:IMAGER3y46:__ASSET__assets_cloudlift_images_cloudlift_pngR5y43:assets%2FcloudLift%2Fimages%2FcloudLift.pnggoR0i2757R1R7R3y50:__ASSET__assets_cloudlift_images_cloudlift_map_pngR5y47:assets%2FcloudLift%2Fimages%2FcloudLift_map.pnggoR0i8103R1R7R3y45:__ASSET__assets_cloudlift_images_elevator_pngR5y42:assets%2FcloudLift%2Fimages%2Felevator.pnggoR0i1326R1R7R3y46:__ASSET__assets_cloudlift_images_item_lamp_pngR5y43:assets%2FcloudLift%2Fimages%2Fitem_lamp.pnggoR0i2029R1R7R3y50:__ASSET__assets_cloudlift_images_platform_mask_pngR5y47:assets%2FcloudLift%2Fimages%2Fplatform_mask.pnggoR0i304R1R7R3y47:__ASSET__assets_cloudlift_images_portal_1_b_pngR5y44:assets%2FcloudLift%2Fimages%2Fportal_1_b.pnggh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("cloudLift", library);
		data = '{"name":null,"assets":"aoy4:sizei11583y4:typey5:IMAGEy9:classNamey31:__ASSET__assets_images_body_pngy2:idy26:assets%2Fimages%2FBody.pnggoR0i8503R1R2R3y32:__ASSET__assets_images_douli_pngR5y27:assets%2Fimages%2FDouli.pnggoR0i2925R1R2R3y33:__ASSET__assets_images_douli2_pngR5y28:assets%2Fimages%2FDouli2.pnggoR0i6591R1R2R3y31:__ASSET__assets_images_face_pngR5y26:assets%2Fimages%2FFace.pnggoR0i1580R1R2R3y34:__ASSET__assets_images_glasses_pngR5y29:assets%2Fimages%2FGlasses.pnggoR0i6221R1R2R3y31:__ASSET__assets_images_hair_pngR5y26:assets%2Fimages%2FHair.pnggoR0i9136R1R2R3y30:__ASSET__assets_images_hat_pngR5y25:assets%2Fimages%2FHat.pnggoR0i2839R1R2R3y31:__ASSET__assets_images_hat2_pngR5y26:assets%2Fimages%2FHat2.pnggoR0i7292R1R2R3y33:__ASSET__assets_images_jacket_pngR5y28:assets%2Fimages%2FJacket.pnggoR0i4981R1R2R3y32:__ASSET__assets_images_jeans_pngR5y27:assets%2Fimages%2FJeans.pnggoR0i9547R1R2R3y35:__ASSET__assets_images_overcoat_pngR5y30:assets%2Fimages%2FOvercoat.pnggoR0i7078R1R2R3y32:__ASSET__assets_images_pants_pngR5y27:assets%2Fimages%2FPants.pnggoR0i4350R1R2R3y32:__ASSET__assets_images_shoes_pngR5y27:assets%2Fimages%2FShoes.pnggoR0i22600R1R2R3y35:__ASSET__assets_images_template_pngR5y30:assets%2Fimages%2FTemplate.pnggoR0i121186R1y5:SOUNDR3y32:__ASSET__assets_sounds_step1_wavR5y27:assets%2Fsounds%2FStep1.wavgoR0i2114R1y5:MUSICR3y31:__ASSET__flixel_sounds_beep_mp3R5y26:flixel%2Fsounds%2Fbeep.mp3goR0i39706R1R36R3y33:__ASSET__flixel_sounds_flixel_mp3R5y28:flixel%2Fsounds%2Fflixel.mp3goR0i15744R1y4:FONTR3y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfgoR0i29724R1R41R3y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfgoR0i519R1R2R3y36:__ASSET__flixel_images_ui_button_pngR5y33:flixel%2Fimages%2Fui%2Fbutton.pnggoR0i3280R1R2R3y39:__ASSET__flixel_images_logo_default_pngR5y36:flixel%2Fimages%2Flogo%2Fdefault.pnggh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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

@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_cloudinforoom_objects_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_cloudinforoom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_cloudinforoom_map_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_item_door1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_item_door2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_item_statue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_portal_1_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_cloudlift_objects_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_cloudlift_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_cloudlift_map_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_elevator_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_item_lamp_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_platform_mask_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_portal_1_b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
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
@:keep @:bind #if display private #end class __ASSET__assets_images_shoes_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_template_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_step1_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_cloudinforoom_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__manifest_cloudlift_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends flash.utils.ByteArray { }


#elseif (desktop || cpp)

@:keep @:file("assets/cloudInfoRoom/cloudInfoRoom_Objects.json") #if display private #end class __ASSET__assets_cloudinforoom_cloudinforoom_objects_json extends haxe.io.Bytes {}
@:keep @:image("assets/cloudInfoRoom/images/cloudInfoRoom.png") #if display private #end class __ASSET__assets_cloudinforoom_images_cloudinforoom_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudInfoRoom/images/cloudInfoRoom_map.png") #if display private #end class __ASSET__assets_cloudinforoom_images_cloudinforoom_map_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudInfoRoom/images/item_door1.png") #if display private #end class __ASSET__assets_cloudinforoom_images_item_door1_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudInfoRoom/images/item_door2.png") #if display private #end class __ASSET__assets_cloudinforoom_images_item_door2_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudInfoRoom/images/item_statue.png") #if display private #end class __ASSET__assets_cloudinforoom_images_item_statue_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudInfoRoom/images/portal_1_a.png") #if display private #end class __ASSET__assets_cloudinforoom_images_portal_1_a_png extends lime.graphics.Image {}
@:keep @:file("assets/cloudLift/cloudLift_Objects.json") #if display private #end class __ASSET__assets_cloudlift_cloudlift_objects_json extends haxe.io.Bytes {}
@:keep @:image("assets/cloudLift/images/cloudLift.png") #if display private #end class __ASSET__assets_cloudlift_images_cloudlift_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudLift/images/cloudLift_map.png") #if display private #end class __ASSET__assets_cloudlift_images_cloudlift_map_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudLift/images/elevator.png") #if display private #end class __ASSET__assets_cloudlift_images_elevator_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudLift/images/item_lamp.png") #if display private #end class __ASSET__assets_cloudlift_images_item_lamp_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudLift/images/platform_mask.png") #if display private #end class __ASSET__assets_cloudlift_images_platform_mask_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudLift/images/portal_1_b.png") #if display private #end class __ASSET__assets_cloudlift_images_portal_1_b_png extends lime.graphics.Image {}
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
@:keep @:image("assets/images/Shoes.png") #if display private #end class __ASSET__assets_images_shoes_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Template.png") #if display private #end class __ASSET__assets_images_template_png extends lime.graphics.Image {}
@:keep @:file("assets/sounds/Step1.wav") #if display private #end class __ASSET__assets_sounds_step1_wav extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,5,0/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") #if display private #end class __ASSET__manifest_cloudinforoom_json extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_cloudlift_json extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Monsterrat"; super (); }}


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