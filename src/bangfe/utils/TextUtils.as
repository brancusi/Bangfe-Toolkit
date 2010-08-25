package bangfe.utils
{
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class TextUtils
	{
		
		/**
		 * Fit text within a specified text field. 
		 * @param field The field to use
		 * @param text The text to fit. If no text is specfied, it will use text already in the field
		 * 
		 */		
		public static function fitText ( field : TextField, text : String = "" ) : void
		{
			var orginalDimensions : Rectangle = new Rectangle(field.x, field.y, field.width, field.height);
			
			var format : TextFormat = new TextFormat(null, 16);
			
			if(text != "")field.htmlText = text;
			
			while (field.textWidth > orginalDimensions.width) {
				format.size = Number(format.size) - 1;
				
				if (format.size <= 0) {
					format.size = 10;
					field.setTextFormat(format);
					break;
				}
				
				field.setTextFormat(format);
				
			}
			
			field.autoSize = TextFieldAutoSize.LEFT;
			field.x = orginalDimensions.x + (orginalDimensions.width/2 - field.width/2);
			field.y = orginalDimensions.y + (orginalDimensions.height/2 - field.height/2);
		}
	
	}
}