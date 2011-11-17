package bangfe.sound.pipe
{
	
	import bangfe.sound.SoundPipeItem;
	
	import system.data.Iterator;
	
	public class CircularSoundPipe extends BaseSoundPipe
	{
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		override protected function handleSoundPlayRequested(p_soundPipeItem : SoundPipeItem ):void
		{
			var it : Iterator = collectionIterator;
			
			while(it.hasNext()){
				var soundPipeItem : SoundPipeItem = it.next() as SoundPipeItem;
				if(soundPipeItem != p_soundPipeItem)removeSound(soundPipeItem);
			}
			
			p_soundPipeItem.play();
		}
		
		override protected function handleSoundCompleted(p_soundPipeItem:SoundPipeItem):void
		{
			p_soundPipeItem.play();
		}
	}
}