package bangfe.batchloader.ioc
{
	public class ContentRequest
	{
		
		protected var _injectionFunction : Function;
		protected var _uid : String;
		protected var _overwrite : Boolean = true;
		protected var _injectionFunctionParams : Array = [];
		
		public function ContentRequest()
		{
		}
		
		public function get injectionFunction () : Function 
		{
			return _injectionFunction; 
		}

		public function set injectionFunction ( p_injectionFunction : Function ) : void 
		{ 
			_injectionFunction = p_injectionFunction; 
		}
		
		public function get uid () : String 
		{
			return _uid; 
		}

		public function set uid ( p_uid : String ) : void 
		{ 
			_uid = p_uid; 
		}
		
		public function get overwrite () : Boolean 
		{
			return _overwrite; 
		}

		public function set overwrite ( p_overwrite : Boolean ) : void 
		{ 
			_overwrite = p_overwrite; 
		}
		
		public function get injectionFunctionParams () : Array 
		{
			return _injectionFunctionParams; 
		}

		public function set injectionFunctionParams ( p_injectionFunctionParams : Array ) : void 
		{ 
			_injectionFunctionParams = p_injectionFunctionParams; 
		}
		
		
	}
}