package
{	
	import bangfe.simpleaudioplayer.SimpleAudioPlayer;
	
	import flash.display.MovieClip;
	
	public class SimpleAudioPlayerTest extends MovieClip
	{
		public var simpleAudioPlayer : SimpleAudioPlayer;
		
		public function SimpleAudioPlayerTest()
		{
			simpleAudioPlayer.source = "sample.mp3";
		}

	}
}