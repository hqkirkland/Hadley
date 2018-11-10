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
		
		data = '{"name":null,"assets":"aoy8:positionzy4:sizezy4:typey4:TEXTy2:idy51:assets%2FcloudInfoRoom%2FcloudInfoRoom_Objects.jsony6:lengthi592goR0i592R1zR2y5:IMAGER4y51:assets%2FcloudInfoRoom%2Fimages%2FcloudInfoRoom.pngR6i58589y7:preloadtgoR0i59181R1zR2R7R4y55:assets%2FcloudInfoRoom%2Fimages%2FcloudInfoRoom_map.pngR6i2485R9tgoR0i61666R1zR2R7R4y48:assets%2FcloudInfoRoom%2Fimages%2Fitem_door1.pngR6i1520R9tgoR0i63186R1zR2R7R4y48:assets%2FcloudInfoRoom%2Fimages%2Fitem_door2.pngR6i891R9tgoR0i64077R1zR2R7R4y49:assets%2FcloudInfoRoom%2Fimages%2Fitem_statue.pngR6i2105R9tgoR0i66182R1zR2R7R4y48:assets%2FcloudInfoRoom%2Fimages%2Fportal_1_a.pngR6i304R9tgh","rootPath":null,"version":2,"libraryArgs":["lib/cloudInfoRoom.pak","pak"],"libraryType":"lime.utils.PackedAssetLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("cloudInfoRoom", library);
		data = '{"name":null,"assets":"aoy8:positionzy4:sizezy4:typey4:TEXTy2:idy43:assets%2FcloudLift%2FcloudLift_Objects.jsony6:lengthi776goR0i776R1zR2y5:IMAGER4y43:assets%2FcloudLift%2Fimages%2FcloudLift.pngR6i124520y7:preloadtgoR0i125296R1zR2R7R4y47:assets%2FcloudLift%2Fimages%2FcloudLift_map.pngR6i2757R9tgoR0i128053R1zR2R7R4y42:assets%2FcloudLift%2Fimages%2Felevator.pngR6i8103R9tgoR0i136156R1zR2R7R4y51:assets%2FcloudLift%2Fimages%2Felevator_dropmask.pngR6i706R9tgoR0i136862R1zR2R7R4y47:assets%2FcloudLift%2Fimages%2Felevator_mask.pngR6i1970R9tgoR0i138832R1zR2R7R4y43:assets%2FcloudLift%2Fimages%2Fitem_lamp.pngR6i1326R9tgoR0i140158R1zR2R7R4y44:assets%2FcloudLift%2Fimages%2Fportal_1_b.pngR6i304R9tgh","rootPath":null,"version":2,"libraryArgs":["lib/cloudLift.pak","pak"],"libraryType":"lime.utils.PackedAssetLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("cloudLift", library);
		data = '{"name":null,"assets":"aoy4:pathy26:assets%2Fimages%2FBody.pngy4:sizei11583y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y27:assets%2Fimages%2FDouli.pngR2i8503R3R4R5R7R6tgoR0y28:assets%2Fimages%2FDouli2.pngR2i2925R3R4R5R8R6tgoR0y26:assets%2Fimages%2FFace.pngR2i6591R3R4R5R9R6tgoR0y29:assets%2Fimages%2FGlasses.pngR2i1580R3R4R5R10R6tgoR0y26:assets%2Fimages%2FHair.pngR2i6221R3R4R5R11R6tgoR0y25:assets%2Fimages%2FHat.pngR2i9136R3R4R5R12R6tgoR0y26:assets%2Fimages%2FHat2.pngR2i2839R3R4R5R13R6tgoR0y54:assets%2Fimages%2Finterface%2FarialBitmap_Size14px.fntR2i21128R3y4:TEXTR5R14R6tgoR0y56:assets%2Fimages%2Finterface%2FarialBitmap_Size14px_0.pngR2i2684R3R4R5R16R6tgoR0y46:assets%2Fimages%2Finterface%2Fbubble_1_1_0.pngR2i254R3R4R5R17R6tgoR0y46:assets%2Fimages%2Finterface%2Fbubble_1_2_0.pngR2i266R3R4R5R18R6tgoR0y46:assets%2Fimages%2Finterface%2Fbubble_1_3_0.pngR2i264R3R4R5R19R6tgoR0y46:assets%2Fimages%2Finterface%2Fbubble_1_4_0.pngR2i263R3R4R5R20R6tgoR0y46:assets%2Fimages%2Finterface%2Fbubble_1_5_0.pngR2i258R3R4R5R21R6tgoR0y46:assets%2Fimages%2Finterface%2Fbubble_1_6_0.pngR2i150R3R4R5R22R6tgoR0y46:assets%2Fimages%2Finterface%2Fbubble_1_7_0.pngR2i164R3R4R5R23R6tgoR0y28:assets%2Fimages%2FJacket.pngR2i7292R3R4R5R24R6tgoR0y27:assets%2Fimages%2FJeans.pngR2i4981R3R4R5R25R6tgoR0y30:assets%2Fimages%2FOvercoat.pngR2i9547R3R4R5R26R6tgoR0y27:assets%2Fimages%2FPants.pngR2i7078R3R4R5R27R6tgoR0y27:assets%2Fimages%2FShoes.pngR2i4350R3R4R5R28R6tgoR0y30:assets%2Fimages%2FTemplate.pngR2i22600R3R4R5R29R6tgoR0R14R2i21128R3R15R5R14R6tgoR0R16R2i2684R3R4R5R16R6tgoR0R17R2i254R3R4R5R17R6tgoR0R18R2i266R3R4R5R18R6tgoR0R19R2i264R3R4R5R19R6tgoR0R20R2i263R3R4R5R20R6tgoR0R21R2i258R3R4R5R21R6tgoR0R22R2i150R3R4R5R22R6tgoR0R23R2i164R3R4R5R23R6tgoR2i121186R3y5:SOUNDR5y27:assets%2Fsounds%2FStep1.wavy9:pathGroupaR31hR6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3R32aR34y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R33R5y28:flixel%2Fsounds%2Fflixel.mp3R32aR36y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R30R5R35R32aR34R35hgoR2i33629R3R30R5R37R32aR36R37hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R38R39y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R4R5R44R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R4R5R45R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Fbox.pngR2i912R3R4R5R46R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fbutton.pngR2i433R3R4R5R47R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_down.pngR2i446R3R4R5R48R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_left.pngR2i459R3R4R5R49R6tgoR0y49:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_right.pngR2i511R3R4R5R50R6tgoR0y46:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_up.pngR2i493R3R4R5R51R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fbutton_thin.pngR2i247R3R4R5R52R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fbutton_toggle.pngR2i534R3R4R5R53R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fcheck_box.pngR2i922R3R4R5R54R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fcheck_mark.pngR2i946R3R4R5R55R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fchrome.pngR2i253R3R4R5R56R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fchrome_flat.pngR2i212R3R4R5R57R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_inset.pngR2i192R3R4R5R58R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_light.pngR2i214R3R4R5R59R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fdropdown_mark.pngR2i156R3R4R5R60R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Ffinger_big.pngR2i1724R3R4R5R61R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Ffinger_small.pngR2i294R3R4R5R62R6tgoR0y38:flixel%2Fflixel-ui%2Fimg%2Fhilight.pngR2i129R3R4R5R63R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Finvis.pngR2i128R3R4R5R64R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fminus_mark.pngR2i136R3R4R5R65R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fplus_mark.pngR2i147R3R4R5R66R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Fradio.pngR2i191R3R4R5R67R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fradio_dot.pngR2i153R3R4R5R68R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fswatch.pngR2i185R3R4R5R69R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Ftab.pngR2i201R3R4R5R70R6tgoR0y39:flixel%2Fflixel-ui%2Fimg%2Ftab_back.pngR2i210R3R4R5R71R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Ftooltip_arrow.pngR2i18509R3R4R5R72R6tgoR0y39:flixel%2Fflixel-ui%2Fxml%2Fdefaults.xmlR2i1263R3R15R5R73R6tgoR0y53:flixel%2Fflixel-ui%2Fxml%2Fdefault_loading_screen.xmlR2i1953R3R15R5R74R6tgoR0y44:flixel%2Fflixel-ui%2Fxml%2Fdefault_popup.xmlR2i1848R3R15R5R75R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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

@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_cloudinforoom_objects_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_cloudinforoom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_cloudinforoom_map_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_item_door1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_item_door2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_item_statue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudinforoom_images_portal_1_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_cloudlift_objects_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_cloudlift_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_cloudlift_map_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_elevator_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_elevator_dropmask_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_elevator_mask_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_item_lamp_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_portal_1_b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_body_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_douli_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_douli2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_face_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_glasses_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hair_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hat2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_arialbitmap_size14px_fnt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_arialbitmap_size14px_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_1_1_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_1_2_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_1_3_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_1_4_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_1_5_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_1_6_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_1_7_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_jacket_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_jeans_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_overcoat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_pants_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shoes_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_template_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_arialbitmap_size15 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_arialbitmap_size16 extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_2 extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_3 extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_4 extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_5 extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_6 extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_7 extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_interface_bubble_8 extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_step1_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__lib_cloudinforoom_pak extends null { }
@:keep @:bind #if display private #end class __ASSET__manifest_cloudinforoom_json extends null { }
@:keep @:bind #if display private #end class __ASSET__lib_cloudlift_pak extends null { }
@:keep @:bind #if display private #end class __ASSET__manifest_cloudlift_json extends null { }
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
@:keep @:file("assets/images/interface/arialBitmap_Size14px.fnt") #if display private #end class __ASSET__assets_images_interface_arialbitmap_size14px_fnt extends haxe.io.Bytes {}
@:keep @:image("assets/images/interface/arialBitmap_Size14px_0.png") #if display private #end class __ASSET__assets_images_interface_arialbitmap_size14px_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_1_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_1_1_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_2_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_1_2_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_3_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_1_3_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_4_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_1_4_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_5_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_1_5_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_6_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_1_6_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_7_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_1_7_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Jacket.png") #if display private #end class __ASSET__assets_images_jacket_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Jeans.png") #if display private #end class __ASSET__assets_images_jeans_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Overcoat.png") #if display private #end class __ASSET__assets_images_overcoat_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Pants.png") #if display private #end class __ASSET__assets_images_pants_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Shoes.png") #if display private #end class __ASSET__assets_images_shoes_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Template.png") #if display private #end class __ASSET__assets_images_template_png extends lime.graphics.Image {}
@:keep @:file("assets/images/interface/arialBitmap_Size14px.fnt") #if display private #end class __ASSET__assets_images_interface_arialbitmap_size15 extends haxe.io.Bytes {}
@:keep @:image("assets/images/interface/arialBitmap_Size14px_0.png") #if display private #end class __ASSET__assets_images_interface_arialbitmap_size16 extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_1_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_2 extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_2_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_3 extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_3_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_4 extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_4_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_5 extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_5_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_6 extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_6_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_7 extends lime.graphics.Image {}
@:keep @:image("assets/images/interface/bubble_1_7_0.png") #if display private #end class __ASSET__assets_images_interface_bubble_8 extends lime.graphics.Image {}
@:keep @:file("assets/sounds/Step1.wav") #if display private #end class __ASSET__assets_sounds_step1_wav extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/box.png") #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_arrow_down.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_arrow_left.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_arrow_right.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_arrow_up.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_thin.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_toggle.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/check_box.png") #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/check_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/chrome.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/chrome_flat.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/chrome_inset.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/chrome_light.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/dropdown_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/finger_big.png") #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/finger_small.png") #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/hilight.png") #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/invis.png") #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/minus_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/plus_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/radio.png") #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/radio_dot.png") #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/swatch.png") #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/tab.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/tab_back.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/tooltip_arrow.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/xml/defaults.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/xml/default_loading_screen.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/xml/default_popup.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends haxe.io.Bytes {}
@:keep @:file("export/html5/obj/libraries/cloudInfoRoom.pak") #if display private #end class __ASSET__lib_cloudinforoom_pak extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_cloudinforoom_json extends haxe.io.Bytes {}
@:keep @:file("export/html5/obj/libraries/cloudLift.pak") #if display private #end class __ASSET__lib_cloudlift_pak extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_cloudlift_json extends haxe.io.Bytes {}
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