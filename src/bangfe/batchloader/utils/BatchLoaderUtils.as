package bangfe.batchloader.utils
{
	import bangfe.batchloader.core.ContentType;
	import bangfe.batchloader.loaders.*;
	
	/**
	 * 
	 * @author Will Zadikian
	 * 
	 */	
	public class BatchLoaderUtils
	{
		
		public function BatchLoaderUtils()
		{
		}
		
		/**
		 * Written by Deburt of http://code.google.com/p/bulk-loader/ 
		 * @param p_urlAsString URL of resource
		 * @return Type of data. Reference : <code>ContentType</code>
		 * 
		 */		
		public static function guessType ( p_urlAsString : String ) : String
		{
            var searchString : String = p_urlAsString.indexOf("?") > -1 ? p_urlAsString.substring(0, p_urlAsString.indexOf("?")) : p_urlAsString;
            var extension : String = searchString.substring(searchString.lastIndexOf(".") + 1).toLowerCase();
            var type : String;
            if(!Boolean(extension) ){
                extension = ContentType.TYPE_TEXT;
            }
            if(extension == ContentType.TYPE_IMAGE || ContentType.IMAGE_EXTENSIONS.indexOf(extension) > -1){
                type = ContentType.TYPE_IMAGE;
            }else if (extension == ContentType.TYPE_SOUND || ContentType.SOUND_EXTENSIONS.indexOf(extension) > -1){
                type = ContentType.TYPE_SOUND;
            }else if (extension == ContentType.TYPE_VIDEO || ContentType.VIDEO_EXTENSIONS.indexOf(extension) > -1){
                type = ContentType.TYPE_VIDEO;
            }else if (extension == ContentType.TYPE_XML || ContentType.XML_EXTENSIONS.indexOf(extension) > -1){
                type = ContentType.TYPE_XML;
            }else if (extension == ContentType.TYPE_MOVIECLIP || ContentType.MOVIECLIP_EXTENSIONS.indexOf(extension) > -1){
                type = ContentType.TYPE_MOVIECLIP;
            }else{
               if (!type) type = ContentType.TYPE_TEXT;
            }
            return type;
        }
        
        /**
         * Get the definition class 
         * @param p_urlAsString
         * @return 
         * 
         */        
        public static function getTypeDefinition ( p_urlAsString : String ) : Class
        {
        	switch(guessType(p_urlAsString)){
        		case ContentType.TYPE_IMAGE :
        			return BinaryLoaderItem;
        			break;

				case ContentType.TYPE_MOVIECLIP :
					return BinaryLoaderItem;
					break;
				
				case ContentType.TYPE_SOUND :
					return AudioLoaderItem;
					break;
        	}
       
        	return DataLoaderItem;

        }

	}
}