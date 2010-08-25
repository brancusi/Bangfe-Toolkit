package bangfe.model.vo
{
	import system.data.collections.ArrayCollection;

	/**
	 * The abstract value object 
	 * @author Will Zadikian
	 * 
	 */
	public class AbstractValueObject
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
		public function AbstractValueObject( p_data : * = null )
		{
			if(p_data != null)data = p_data;
		}
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------
		
		/**
		 * The raw data passed into this VO 
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
		}
		
	}
}