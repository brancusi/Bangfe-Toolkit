package bangfe.sound.pipe
{
	import bangfe.sound.SoundPipeItem;
	
	import system.data.Iterator;
	
	/**
	 * This sound pipe type plays sounds back to back.  
	 * @author Will Zadikian
	 * 
	 */	
	public class LinearSoundPipe extends BaseSoundPipe
	{
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _isActive : Boolean = false;
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		override protected function handleSoundPlayRequested(p_soundPipeItem : SoundPipeItem ):void
		{
			if(!_isActive)p_soundPipeItem.play();
		}
		
		override protected function handleSoundStarted (p_soundPipeItem:SoundPipeItem):void
		{
			_isActive = true;
		}
		
		override protected function handleSoundCompleted(p_soundPipeItem:SoundPipeItem):void
		{
			_isActive = false;
			removeSound(p_soundPipeItem);
			
			var it : Iterator = collectionIterator;
			var soundPipeItem : SoundPipeItem;
			if(it.hasNext()){
				soundPipeItem = it.next() as SoundPipeItem;
				soundPipeItem.play();
			}
		}
	}
}