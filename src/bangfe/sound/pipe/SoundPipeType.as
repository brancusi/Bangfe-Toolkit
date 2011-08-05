package bangfe.sound.pipe
{
	import system.data.collections.ArrayCollection;

	public class SoundPipeType
	{
		
		/**
		 * Plays a single sound at a time. Any newly added sound instantly override
		 * anything that is currently playing 
		 */		
		public static const SINGLE : String = "__singleSoundPipe__";
		
		/**
		 * Appends new sounds to the end of the stack and plays First in First Out  
		 */		
		public static const LINEAR : String = "__linearSoundPipe__";
		
		/**
		 * Plays in a loop. Any sounds added are appended and the whole track loops 
		 */		
		public static const CIRCULAR : String = "__circularSoundPipe__";
		
		/**
		 * Plays sound concurrently 
		 */		
		public static const CONCURRENT : String = "__concurrentSoundPipe__";
		
		/**
		 * The enum for the types 
		 */		
		public static const TYPE_ENUM : ArrayCollection = new ArrayCollection([SINGLE, LINEAR, CIRCULAR, CONCURRENT]);
		
	}
}