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
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end

		}

		Assets.defaultRootPath = rootPath;

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_interface_fonts_helveticarounded_bold_otf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_interface_fonts_helveticaroundedlt_black_otf);
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

		data = '{"name":null,"assets":"aoy4:sizei592y4:typey4:TEXTy9:classNamey56:__ASSET__assets_cloudinforoom_cloudinforoom_objects_jsony2:idy51:assets%2FcloudInfoRoom%2FcloudInfoRoom_Objects.jsongoR0i58589R1y5:IMAGER3y54:__ASSET__assets_cloudinforoom_images_cloudinforoom_pngR5y51:assets%2FcloudInfoRoom%2Fimages%2FcloudInfoRoom.pnggoR0i2485R1R7R3y58:__ASSET__assets_cloudinforoom_images_cloudinforoom_map_pngR5y55:assets%2FcloudInfoRoom%2Fimages%2FcloudInfoRoom_map.pnggoR0i1520R1R7R3y51:__ASSET__assets_cloudinforoom_images_item_door1_pngR5y48:assets%2FcloudInfoRoom%2Fimages%2Fitem_door1.pnggoR0i891R1R7R3y51:__ASSET__assets_cloudinforoom_images_item_door2_pngR5y48:assets%2FcloudInfoRoom%2Fimages%2Fitem_door2.pnggoR0i2105R1R7R3y52:__ASSET__assets_cloudinforoom_images_item_statue_pngR5y49:assets%2FcloudInfoRoom%2Fimages%2Fitem_statue.pnggoR0i304R1R7R3y51:__ASSET__assets_cloudinforoom_images_portal_1_a_pngR5y48:assets%2FcloudInfoRoom%2Fimages%2Fportal_1_a.pnggh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("cloudInfoRoom", library);
		data = '{"name":null,"assets":"aoy4:sizei776y4:typey4:TEXTy9:classNamey48:__ASSET__assets_cloudlift_cloudlift_objects_jsony2:idy43:assets%2FcloudLift%2FcloudLift_Objects.jsongoR0i124520R1y5:IMAGER3y46:__ASSET__assets_cloudlift_images_cloudlift_pngR5y43:assets%2FcloudLift%2Fimages%2FcloudLift.pnggoR0i2757R1R7R3y50:__ASSET__assets_cloudlift_images_cloudlift_map_pngR5y47:assets%2FcloudLift%2Fimages%2FcloudLift_map.pnggoR0i8103R1R7R3y45:__ASSET__assets_cloudlift_images_elevator_pngR5y42:assets%2FcloudLift%2Fimages%2Felevator.pnggoR0i706R1R7R3y54:__ASSET__assets_cloudlift_images_elevator_dropmask_pngR5y51:assets%2FcloudLift%2Fimages%2Felevator_dropmask.pnggoR0i1970R1R7R3y50:__ASSET__assets_cloudlift_images_elevator_mask_pngR5y47:assets%2FcloudLift%2Fimages%2Felevator_mask.pnggoR0i1326R1R7R3y46:__ASSET__assets_cloudlift_images_item_lamp_pngR5y43:assets%2FcloudLift%2Fimages%2Fitem_lamp.pnggoR0i304R1R7R3y47:__ASSET__assets_cloudlift_images_portal_1_b_pngR5y44:assets%2FcloudLift%2Fimages%2Fportal_1_b.pnggh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("cloudLift", library);
		data = '{"name":null,"assets":"aoy4:sizei3620y4:typey5:IMAGEy9:classNamey69:__ASSET__assets_interface_starboard_elements_gamebar_gamebar_base_pngy2:idy70:assets%2Finterface%2Fstarboard%2Felements%2Fgamebar%2Fgamebar_base.pnggoR0i3293R1R2R3y73:__ASSET__assets_interface_starboard_elements_gamebar_gamebar_chat_box_pngR5y74:assets%2Finterface%2Fstarboard%2Felements%2Fgamebar%2Fgamebar_chat_box.pnggoR0i1435R1R2R3y78:__ASSET__assets_interface_starboard_elements_gamebar_gamebar_mirror_avatar_pngR5y79:assets%2Finterface%2Fstarboard%2Felements%2Fgamebar%2Fgamebar_mirror_avatar.pnggoR0i374R1R2R3y76:__ASSET__assets_interface_starboard_elements_gamebar_gamebar_mirror_mask_pngR5y77:assets%2Finterface%2Fstarboard%2Felements%2Fgamebar%2Fgamebar_mirror_mask.pnggoR0i573R1R2R3y75:__ASSET__assets_interface_starboard_elements_gamebar_gamebar_mirror_pet_pngR5y76:assets%2Finterface%2Fstarboard%2Felements%2Fgamebar%2Fgamebar_mirror_pet.pnggoR0i710R1R2R3y74:__ASSET__assets_interface_starboard_elements_gamebar_gamebar_seal_left_pngR5y75:assets%2Finterface%2Fstarboard%2Felements%2Fgamebar%2Fgamebar_seal_left.pnggoR0i729R1R2R3y75:__ASSET__assets_interface_starboard_elements_gamebar_gamebar_seal_right_pngR5y76:assets%2Finterface%2Fstarboard%2Felements%2Fgamebar%2Fgamebar_seal_right.pnggoR0i1942R1R2R3y67:__ASSET__assets_interface_starboard_elements_volume_volume_icon_pngR5y68:assets%2Finterface%2Fstarboard%2Felements%2Fvolume%2Fvolume_icon.pnggoR0i302R1R2R3y74:__ASSET__assets_interface_starboard_elements_window_window_bottom_left_pngR5y75:assets%2Finterface%2Fstarboard%2Felements%2Fwindow%2Fwindow_bottom_left.pnggoR0i183R1R2R3y73:__ASSET__assets_interface_starboard_elements_window_window_bottom_mid_pngR5y74:assets%2Finterface%2Fstarboard%2Felements%2Fwindow%2Fwindow_bottom_mid.pnggoR0i305R1R2R3y75:__ASSET__assets_interface_starboard_elements_window_window_bottom_right_pngR5y76:assets%2Finterface%2Fstarboard%2Felements%2Fwindow%2Fwindow_bottom_right.pnggoR0i550R1R2R3y71:__ASSET__assets_interface_starboard_elements_window_window_top_left_pngR5y72:assets%2Finterface%2Fstarboard%2Felements%2Fwindow%2Fwindow_top_left.pnggoR0i169R1R2R3y70:__ASSET__assets_interface_starboard_elements_window_window_top_mid_pngR5y71:assets%2Finterface%2Fstarboard%2Felements%2Fwindow%2Fwindow_top_mid.pnggoR0i569R1R2R3y72:__ASSET__assets_interface_starboard_elements_window_window_top_right_pngR5y73:assets%2Finterface%2Fstarboard%2Felements%2Fwindow%2Fwindow_top_right.pnggoR0i244R1R2R3y64:__ASSET__assets_interface_starboard_elements_window_window_x_pngR5y65:assets%2Finterface%2Fstarboard%2Felements%2Fwindow%2Fwindow_x.pnggoR0i227676R1y4:TEXTR3y48:__ASSET__assets_interface_starboard_worldmap_pdnR5y45:assets%2Finterface%2Fstarboard%2FworldMap.pdngoR0i116682R1R2R3y48:__ASSET__assets_interface_starboard_worldmap_pngR5y45:assets%2Finterface%2Fstarboard%2FworldMap.pnggh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("starboard", library);
		data = '{"name":null,"assets":"aoy4:sizei21128y4:typey4:TEXTy9:classNamey55:__ASSET__assets_interface_chat_arialbitmap_size14px_fnty2:idy52:assets%2Finterface%2Fchat%2FarialBitmap_Size14px.fntgoR0i2684R1y5:IMAGER3y57:__ASSET__assets_interface_chat_arialbitmap_size14px_0_pngR5y54:assets%2Finterface%2Fchat%2FarialBitmap_Size14px_0.pnggoR0i254R1R7R3y47:__ASSET__assets_interface_chat_bubble_1_1_0_pngR5y44:assets%2Finterface%2Fchat%2Fbubble_1_1_0.pnggoR0i266R1R7R3y47:__ASSET__assets_interface_chat_bubble_1_2_0_pngR5y44:assets%2Finterface%2Fchat%2Fbubble_1_2_0.pnggoR0i264R1R7R3y47:__ASSET__assets_interface_chat_bubble_1_3_0_pngR5y44:assets%2Finterface%2Fchat%2Fbubble_1_3_0.pnggoR0i263R1R7R3y47:__ASSET__assets_interface_chat_bubble_1_4_0_pngR5y44:assets%2Finterface%2Fchat%2Fbubble_1_4_0.pnggoR0i258R1R7R3y47:__ASSET__assets_interface_chat_bubble_1_5_0_pngR5y44:assets%2Finterface%2Fchat%2Fbubble_1_5_0.pnggoR0i150R1R7R3y47:__ASSET__assets_interface_chat_bubble_1_6_0_pngR5y44:assets%2Finterface%2Fchat%2Fbubble_1_6_0.pnggoR0i164R1R7R3y47:__ASSET__assets_interface_chat_bubble_1_7_0_pngR5y44:assets%2Finterface%2Fchat%2Fbubble_1_7_0.pnggoR0i31648R1y4:FONTR3y57:__ASSET__assets_interface_fonts_helveticarounded_bold_otfR5y54:assets%2Finterface%2Ffonts%2FHelveticaRounded-Bold.otfgoR0i32452R1R24R3y60:__ASSET__assets_interface_fonts_helveticaroundedlt_black_otfR5y57:assets%2Finterface%2Ffonts%2FHelveticaRoundedLT-Black.otfgoR0i461R1R7R3y51:__ASSET__assets_interface_login_images_emptybox_pngR5y50:assets%2Finterface%2Flogin%2Fimages%2FemptyBox.pnggoR0i466R1R7R3y54:__ASSET__assets_interface_login_images_greenbutton_pngR5y53:assets%2Finterface%2Flogin%2Fimages%2FgreenButton.pnggoR0i466R1R7R3y60:__ASSET__assets_interface_login_images_greenbutton_hover_pngR5y59:assets%2Finterface%2Flogin%2Fimages%2FgreenButton_hover.pnggoR0i506R1R7R3y60:__ASSET__assets_interface_login_images_greenbutton_press_pngR5y59:assets%2Finterface%2Flogin%2Fimages%2FgreenButton_press.pnggoR0i464632R1R7R3y51:__ASSET__assets_interface_login_images_panorama_pngR5y50:assets%2Finterface%2Flogin%2Fimages%2Fpanorama.pnggoR0i11583R1R7R3y27:__ASSET__assets_items_1_pngR5y22:assets%2Fitems%2F1.pnggoR0i4350R1R7R3y27:__ASSET__assets_items_2_pngR5y22:assets%2Fitems%2F2.pnggoR0i4981R1R7R3y27:__ASSET__assets_items_3_pngR5y22:assets%2Fitems%2F3.pnggoR0i9547R1R7R3y27:__ASSET__assets_items_4_pngR5y22:assets%2Fitems%2F4.pnggoR0i8503R1R7R3y27:__ASSET__assets_items_5_pngR5y22:assets%2Fitems%2F5.pnggoR0i2925R1R7R3y28:__ASSET__assets_items_5b_pngR5y23:assets%2Fitems%2F5b.pnggoR0i6591R1R7R3y27:__ASSET__assets_items_6_pngR5y22:assets%2Fitems%2F6.pnggoR0i6221R1R7R3y27:__ASSET__assets_items_7_pngR5y22:assets%2Fitems%2F7.pnggoR0i1580R1R7R3y27:__ASSET__assets_items_8_pngR5y22:assets%2Fitems%2F8.pnggoR0i7292R1R7R3y32:__ASSET__assets_items_jacket_pngR5y27:assets%2Fitems%2FJacket.pnggoR0i7078R1R7R3y31:__ASSET__assets_items_pants_pngR5y26:assets%2Fitems%2FPants.pnggoR0i22600R1R7R3y34:__ASSET__assets_items_template_pngR5y29:assets%2Fitems%2FTemplate.pnggoR0i121186R1y5:SOUNDR3y32:__ASSET__assets_sounds_step1_wavR5y27:assets%2Fsounds%2FStep1.wavgoR0i2114R1y5:MUSICR3y31:__ASSET__flixel_sounds_beep_mp3R5y26:flixel%2Fsounds%2Fbeep.mp3goR0i39706R1R66R3y33:__ASSET__flixel_sounds_flixel_mp3R5y28:flixel%2Fsounds%2Fflixel.mp3goR0i15744R1R24R3y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfgoR0i29724R1R24R3y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfgoR0i519R1R7R3y36:__ASSET__flixel_images_ui_button_pngR5y33:flixel%2Fimages%2Fui%2Fbutton.pnggoR0i3280R1R7R3y39:__ASSET__flixel_images_logo_default_pngR5y36:flixel%2Fimages%2Flogo%2Fdefault.pnggoR0i912R1R7R3y37:__ASSET__flixel_flixel_ui_img_box_pngR5y34:flixel%2Fflixel-ui%2Fimg%2Fbox.pnggoR0i433R1R7R3y40:__ASSET__flixel_flixel_ui_img_button_pngR5y37:flixel%2Fflixel-ui%2Fimg%2Fbutton.pnggoR0i446R1R7R3y51:__ASSET__flixel_flixel_ui_img_button_arrow_down_pngR5y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_down.pnggoR0i459R1R7R3y51:__ASSET__flixel_flixel_ui_img_button_arrow_left_pngR5y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_left.pnggoR0i511R1R7R3y52:__ASSET__flixel_flixel_ui_img_button_arrow_right_pngR5y49:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_right.pnggoR0i493R1R7R3y49:__ASSET__flixel_flixel_ui_img_button_arrow_up_pngR5y46:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_up.pnggoR0i247R1R7R3y45:__ASSET__flixel_flixel_ui_img_button_thin_pngR5y42:flixel%2Fflixel-ui%2Fimg%2Fbutton_thin.pnggoR0i534R1R7R3y47:__ASSET__flixel_flixel_ui_img_button_toggle_pngR5y44:flixel%2Fflixel-ui%2Fimg%2Fbutton_toggle.pnggoR0i922R1R7R3y43:__ASSET__flixel_flixel_ui_img_check_box_pngR5y40:flixel%2Fflixel-ui%2Fimg%2Fcheck_box.pnggoR0i946R1R7R3y44:__ASSET__flixel_flixel_ui_img_check_mark_pngR5y41:flixel%2Fflixel-ui%2Fimg%2Fcheck_mark.pnggoR0i253R1R7R3y40:__ASSET__flixel_flixel_ui_img_chrome_pngR5y37:flixel%2Fflixel-ui%2Fimg%2Fchrome.pnggoR0i212R1R7R3y45:__ASSET__flixel_flixel_ui_img_chrome_flat_pngR5y42:flixel%2Fflixel-ui%2Fimg%2Fchrome_flat.pnggoR0i192R1R7R3y46:__ASSET__flixel_flixel_ui_img_chrome_inset_pngR5y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_inset.pnggoR0i214R1R7R3y46:__ASSET__flixel_flixel_ui_img_chrome_light_pngR5y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_light.pnggoR0i156R1R7R3y47:__ASSET__flixel_flixel_ui_img_dropdown_mark_pngR5y44:flixel%2Fflixel-ui%2Fimg%2Fdropdown_mark.pnggoR0i1724R1R7R3y44:__ASSET__flixel_flixel_ui_img_finger_big_pngR5y41:flixel%2Fflixel-ui%2Fimg%2Ffinger_big.pnggoR0i294R1R7R3y46:__ASSET__flixel_flixel_ui_img_finger_small_pngR5y43:flixel%2Fflixel-ui%2Fimg%2Ffinger_small.pnggoR0i129R1R7R3y41:__ASSET__flixel_flixel_ui_img_hilight_pngR5y38:flixel%2Fflixel-ui%2Fimg%2Fhilight.pnggoR0i128R1R7R3y39:__ASSET__flixel_flixel_ui_img_invis_pngR5y36:flixel%2Fflixel-ui%2Fimg%2Finvis.pnggoR0i136R1R7R3y44:__ASSET__flixel_flixel_ui_img_minus_mark_pngR5y41:flixel%2Fflixel-ui%2Fimg%2Fminus_mark.pnggoR0i147R1R7R3y43:__ASSET__flixel_flixel_ui_img_plus_mark_pngR5y40:flixel%2Fflixel-ui%2Fimg%2Fplus_mark.pnggoR0i191R1R7R3y39:__ASSET__flixel_flixel_ui_img_radio_pngR5y36:flixel%2Fflixel-ui%2Fimg%2Fradio.pnggoR0i153R1R7R3y43:__ASSET__flixel_flixel_ui_img_radio_dot_pngR5y40:flixel%2Fflixel-ui%2Fimg%2Fradio_dot.pnggoR0i185R1R7R3y40:__ASSET__flixel_flixel_ui_img_swatch_pngR5y37:flixel%2Fflixel-ui%2Fimg%2Fswatch.pnggoR0i201R1R7R3y37:__ASSET__flixel_flixel_ui_img_tab_pngR5y34:flixel%2Fflixel-ui%2Fimg%2Ftab.pnggoR0i210R1R7R3y42:__ASSET__flixel_flixel_ui_img_tab_back_pngR5y39:flixel%2Fflixel-ui%2Fimg%2Ftab_back.pnggoR0i18509R1R7R3y47:__ASSET__flixel_flixel_ui_img_tooltip_arrow_pngR5y44:flixel%2Fflixel-ui%2Fimg%2Ftooltip_arrow.pnggoR0i1263R1R2R3y42:__ASSET__flixel_flixel_ui_xml_defaults_xmlR5y39:flixel%2Fflixel-ui%2Fxml%2Fdefaults.xmlgoR0i1953R1R2R3y56:__ASSET__flixel_flixel_ui_xml_default_loading_screen_xmlR5y53:flixel%2Fflixel-ui%2Fxml%2Fdefault_loading_screen.xmlgoR0i1848R1R2R3y47:__ASSET__flixel_flixel_ui_xml_default_popup_xmlR5y44:flixel%2Fflixel-ui%2Fxml%2Fdefault_popup.xmlgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_elevator_dropmask_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_elevator_mask_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_item_lamp_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cloudlift_images_portal_1_b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_base_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_chat_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_mirror_avatar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_mirror_mask_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_mirror_pet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_seal_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_seal_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_volume_volume_icon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_bottom_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_bottom_mid_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_bottom_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_top_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_top_mid_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_top_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_x_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_worldmap_pdn extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_interface_starboard_worldmap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_chat_arialbitmap_size14px_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_interface_chat_arialbitmap_size14px_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_chat_bubble_1_1_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_chat_bubble_1_2_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_chat_bubble_1_3_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_chat_bubble_1_4_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_chat_bubble_1_5_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_chat_bubble_1_6_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_chat_bubble_1_7_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_fonts_helveticarounded_bold_otf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_interface_fonts_helveticaroundedlt_black_otf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_interface_login_images_emptybox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_login_images_greenbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_login_images_greenbutton_hover_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_login_images_greenbutton_press_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_interface_login_images_panorama_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_5b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_8_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_jacket_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_pants_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_items_template_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_step1_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends flash.text.Font { }
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
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__manifest_cloudinforoom_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__manifest_cloudlift_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__manifest_starboard_json extends flash.utils.ByteArray { }
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
@:keep @:image("assets/cloudLift/images/elevator_dropmask.png") #if display private #end class __ASSET__assets_cloudlift_images_elevator_dropmask_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudLift/images/elevator_mask.png") #if display private #end class __ASSET__assets_cloudlift_images_elevator_mask_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudLift/images/item_lamp.png") #if display private #end class __ASSET__assets_cloudlift_images_item_lamp_png extends lime.graphics.Image {}
@:keep @:image("assets/cloudLift/images/portal_1_b.png") #if display private #end class __ASSET__assets_cloudlift_images_portal_1_b_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/gamebar/gamebar_base.png") #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_base_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/gamebar/gamebar_chat_box.png") #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_chat_box_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/gamebar/gamebar_mirror_avatar.png") #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_mirror_avatar_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/gamebar/gamebar_mirror_mask.png") #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_mirror_mask_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/gamebar/gamebar_mirror_pet.png") #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_mirror_pet_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/gamebar/gamebar_seal_left.png") #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_seal_left_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/gamebar/gamebar_seal_right.png") #if display private #end class __ASSET__assets_interface_starboard_elements_gamebar_gamebar_seal_right_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/volume/volume_icon.png") #if display private #end class __ASSET__assets_interface_starboard_elements_volume_volume_icon_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/window/window_bottom_left.png") #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_bottom_left_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/window/window_bottom_mid.png") #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_bottom_mid_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/window/window_bottom_right.png") #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_bottom_right_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/window/window_top_left.png") #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_top_left_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/window/window_top_mid.png") #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_top_mid_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/window/window_top_right.png") #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_top_right_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/starboard/elements/window/window_x.png") #if display private #end class __ASSET__assets_interface_starboard_elements_window_window_x_png extends lime.graphics.Image {}
@:keep @:file("assets/interface/starboard/worldMap.pdn") #if display private #end class __ASSET__assets_interface_starboard_worldmap_pdn extends haxe.io.Bytes {}
@:keep @:image("assets/interface/starboard/worldMap.png") #if display private #end class __ASSET__assets_interface_starboard_worldmap_png extends lime.graphics.Image {}
@:keep @:file("assets/interface/chat/arialBitmap_Size14px.fnt") #if display private #end class __ASSET__assets_interface_chat_arialbitmap_size14px_fnt extends haxe.io.Bytes {}
@:keep @:image("assets/interface/chat/arialBitmap_Size14px_0.png") #if display private #end class __ASSET__assets_interface_chat_arialbitmap_size14px_0_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/chat/bubble_1_1_0.png") #if display private #end class __ASSET__assets_interface_chat_bubble_1_1_0_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/chat/bubble_1_2_0.png") #if display private #end class __ASSET__assets_interface_chat_bubble_1_2_0_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/chat/bubble_1_3_0.png") #if display private #end class __ASSET__assets_interface_chat_bubble_1_3_0_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/chat/bubble_1_4_0.png") #if display private #end class __ASSET__assets_interface_chat_bubble_1_4_0_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/chat/bubble_1_5_0.png") #if display private #end class __ASSET__assets_interface_chat_bubble_1_5_0_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/chat/bubble_1_6_0.png") #if display private #end class __ASSET__assets_interface_chat_bubble_1_6_0_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/chat/bubble_1_7_0.png") #if display private #end class __ASSET__assets_interface_chat_bubble_1_7_0_png extends lime.graphics.Image {}
@:keep @:font("assets/interface/fonts/HelveticaRounded-Bold.otf") #if display private #end class __ASSET__assets_interface_fonts_helveticarounded_bold_otf extends lime.text.Font {}
@:keep @:font("assets/interface/fonts/HelveticaRoundedLT-Black.otf") #if display private #end class __ASSET__assets_interface_fonts_helveticaroundedlt_black_otf extends lime.text.Font {}
@:keep @:image("assets/interface/login/images/emptyBox.png") #if display private #end class __ASSET__assets_interface_login_images_emptybox_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/login/images/greenButton.png") #if display private #end class __ASSET__assets_interface_login_images_greenbutton_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/login/images/greenButton_hover.png") #if display private #end class __ASSET__assets_interface_login_images_greenbutton_hover_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/login/images/greenButton_press.png") #if display private #end class __ASSET__assets_interface_login_images_greenbutton_press_png extends lime.graphics.Image {}
@:keep @:image("assets/interface/login/images/panorama.png") #if display private #end class __ASSET__assets_interface_login_images_panorama_png extends lime.graphics.Image {}
@:keep @:image("assets/items/1.png") #if display private #end class __ASSET__assets_items_1_png extends lime.graphics.Image {}
@:keep @:image("assets/items/2.png") #if display private #end class __ASSET__assets_items_2_png extends lime.graphics.Image {}
@:keep @:image("assets/items/3.png") #if display private #end class __ASSET__assets_items_3_png extends lime.graphics.Image {}
@:keep @:image("assets/items/4.png") #if display private #end class __ASSET__assets_items_4_png extends lime.graphics.Image {}
@:keep @:image("assets/items/5.png") #if display private #end class __ASSET__assets_items_5_png extends lime.graphics.Image {}
@:keep @:image("assets/items/5b.png") #if display private #end class __ASSET__assets_items_5b_png extends lime.graphics.Image {}
@:keep @:image("assets/items/6.png") #if display private #end class __ASSET__assets_items_6_png extends lime.graphics.Image {}
@:keep @:image("assets/items/7.png") #if display private #end class __ASSET__assets_items_7_png extends lime.graphics.Image {}
@:keep @:image("assets/items/8.png") #if display private #end class __ASSET__assets_items_8_png extends lime.graphics.Image {}
@:keep @:image("assets/items/Jacket.png") #if display private #end class __ASSET__assets_items_jacket_png extends lime.graphics.Image {}
@:keep @:image("assets/items/Pants.png") #if display private #end class __ASSET__assets_items_pants_png extends lime.graphics.Image {}
@:keep @:image("assets/items/Template.png") #if display private #end class __ASSET__assets_items_template_png extends lime.graphics.Image {}
@:keep @:file("assets/sounds/Step1.wav") #if display private #end class __ASSET__assets_sounds_step1_wav extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,6,0/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,6,0/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/4,6,0/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/4,6,0/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,6,0/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,6,0/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/box.png") #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_arrow_down.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_arrow_left.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_arrow_right.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_arrow_up.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_thin.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_toggle.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/check_box.png") #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/check_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/chrome.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/chrome_flat.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/chrome_inset.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/chrome_light.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/dropdown_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/finger_big.png") #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/finger_small.png") #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/hilight.png") #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/invis.png") #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/minus_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/plus_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/radio.png") #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/radio_dot.png") #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/swatch.png") #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/tab.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/tab_back.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/tooltip_arrow.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/xml/defaults.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/xml/default_loading_screen.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/xml/default_popup.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_cloudinforoom_json extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_cloudlift_json extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_starboard_json extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_interface_fonts_helveticarounded_bold_otf') #if display private #end class __ASSET__assets_interface_fonts_helveticarounded_bold_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/interface/fonts/HelveticaRounded-Bold.otf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Helvetica Rounded Bold"; super (); }}
@:keep @:expose('__ASSET__assets_interface_fonts_helveticaroundedlt_black_otf') #if display private #end class __ASSET__assets_interface_fonts_helveticaroundedlt_black_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/interface/fonts/HelveticaRoundedLT-Black.otf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Helvetica Rounded LT Black"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_interface_fonts_helveticarounded_bold_otf') #if display private #end class __ASSET__OPENFL__assets_interface_fonts_helveticarounded_bold_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_interface_fonts_helveticarounded_bold_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_interface_fonts_helveticaroundedlt_black_otf') #if display private #end class __ASSET__OPENFL__assets_interface_fonts_helveticaroundedlt_black_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_interface_fonts_helveticaroundedlt_black_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_interface_fonts_helveticarounded_bold_otf') #if display private #end class __ASSET__OPENFL__assets_interface_fonts_helveticarounded_bold_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_interface_fonts_helveticarounded_bold_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_interface_fonts_helveticaroundedlt_black_otf') #if display private #end class __ASSET__OPENFL__assets_interface_fonts_helveticaroundedlt_black_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_interface_fonts_helveticaroundedlt_black_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end