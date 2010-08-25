package bangfe.utils
{
	import bangfe.model.vo.AbstractValueObject;
	
	import system.data.collections.ArrayCollection;

	public class FactoryUtils
	{
		
		//--------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//--------------------------------------
		public static const VO_TYPE_ERROR_MESSAGE : String = "The definition must be of type AbstractValueObject";
		
		//--------------------------------------
		//  STATIC METHODS
		//--------------------------------------
		/**
		 * Build an <code>ArrayCollection</code> from the supplied data, can be either XMLList or Array. Each item of the list will be passed into
		 * the constructor of the supplied AbstractValueObject definition instance
		 *  
		 * @param p_data The data either XMLList or Array
		 * @param p_classDefinition The class definition to generate and inject with each iteration. Must be type <code>AbstractValueObject</code>
		 * @return 
		 * 
		 */		
		public static function generateVOCollection ( p_data : *, p_classDefinition : Class = null ) : ArrayCollection
		{
			//Run type test. Will throw and error if the type is not AbstractValueObject
			if(p_classDefinition != null){
				var testInstance : * = new p_classDefinition();
				if(!(testInstance is AbstractValueObject))throw new Error(VO_TYPE_ERROR_MESSAGE);
			}
			
			var collection : ArrayCollection = new ArrayCollection();
			var itemCount : int = 0;
			
			if(p_data is Array){
				itemCount = p_data.length;
			}else if(p_data is XMLList){
				itemCount = p_data.length();
			}
			
			for (var i : int = 0; i < itemCount; i++) {
				if(p_classDefinition != null){
					collection.add(new p_classDefinition(p_data[i]));
				}else{
					collection.add(p_data[i]);
				}
			}	
		
			return collection;
		}
	}
}