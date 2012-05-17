package bangfe.sound.pipe
{
	import bangfe.sound.SoundPipeItem;
	
	import system.data.Iterator;
	
	public class ConcurrentSoundPipe extends BaseSoundPipe
	{
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		override protected function handleSoundPlayRequested(p_soundPipeItem : SoundPipeItem ):void
		{			
			p_soundPipeItem.play();
		}
		
		override protected function handleSoundCompleted(p_soundPipeItem:SoundPipeItem):void
		{
			removeSound(p_soundPipeItem);
		}
		
	}
}