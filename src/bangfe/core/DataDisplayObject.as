package bangfe.core
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * The DataDisplayObject can be used as the baseclass for any <code>DisplayObject</code> that 
	 * requires data of some type.
	 * 
	 * By setting the data property, the object is drawn.
	 * 
	 * @see bangfe.core.CoreDisplayObject
	 * 
	 * @author Will Zadikian
	 * 
	 */
	public class DataDisplayObject extends CoreDisplayObject
	{
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _data : *;

		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor 
		 * 
		 */
		public function DataDisplayObject()
		{
			super();
		}
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------
		/**
		 * The data object used by the DataDisplayObject.
		 * @return 
		 * 
		 */
		public function get data () : *
		{
			return _data;
		}
		
		public function set data ( p_data : * ) : void
		{
			_data = p_data;
			processData();
			draw();
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		/**
		 * Process the newly set data if needed. 
		 * 
		 */		
		protected function processData () : void
		{
			//Override
		}
		
		/**
		 * Draw in concrete class 
		 * 
		 */
		protected function draw () : void
		{
			//Override
		}
		
	}
}