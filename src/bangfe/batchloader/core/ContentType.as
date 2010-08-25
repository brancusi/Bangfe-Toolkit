package  bangfe.batchloader.core
{
	public class ContentType
	{
		
		/** Tells this class to use a <code>Loader</code> object to load the item.*/
        public static const TYPE_BINARY : String = "binary";
        
        /** Tells this class to use a <code>Loader</code> object to load the item.*/
        public static const TYPE_IMAGE : String = "image";
        
        /** Tells this class to use a <code>Loader</code> object to load the item.*/
        public static const TYPE_MOVIECLIP : String = "movieclip";
        
        /** Tells this class to use a <code>Sound</code> object to load the item.*/
        public static const TYPE_SOUND : String = "sound";
        
        /** Tells this class to use a <code>URLRequest</code> object to load the item.*/
        public static const TYPE_TEXT : String = "text";
        
        /** Tells this class to use a <code>XML</code> object to load the item.*/
        public static const TYPE_XML : String = "xml";
        
        /** Tells this class to use a <code>NetStream</code> object to load the item.*/
        public static const TYPE_VIDEO : String = "video";
  
        public static var AVAILABLE_EXTENSIONS : Array = ["swf", "jpg", "jpeg", "gif", "png", "flv", "mp3", "xml", "txt", "js" ];
        /** List of file extensions that will be automagically use a <code>Loader</code> object for loading.
        *   Availabe types: swf, jpg, jpeg, gif, png, image.
        */
        public static var IMAGE_EXTENSIONS : Array = [ "jpg", "jpeg", "gif", "png"];
        
        public static var MOVIECLIP_EXTENSIONS : Array = ['swf'];
        /** List of file extensions that will be automagically treated as text for loading.
        *   Availabe types: txt, js, xml, php, asp .
        */
        public static var TEXT_EXTENSIONS : Array = ["txt", "js", "php", "asp", "py" ];
        /** List of file extensions that will be automagically treated as video for loading. 
        *  Availabe types: flv, f4v, f4p. 
        */
        public static var VIDEO_EXTENSIONS : Array = ["flv", "f4v", "f4p", "mp4"];
        /** List of file extensions that will be automagically treated as sound for loading.
        *  Availabe types: mp3, f4a, f4b.
        */
        public static var SOUND_EXTENSIONS : Array = ["mp3", "f4a", "f4b"];
        
        public static var XML_EXTENSIONS : Array = ["xml"];

	}
}