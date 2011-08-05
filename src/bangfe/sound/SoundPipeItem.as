package bangfe.sound
{
	import bangfe.core.ICoreObject;
	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import org.osflash.signals.Signal;
	
	public class SoundPipeItem implements ICoreObject
	{
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _sound : Sound;
		private var _originTransform : SoundTransform;
		private var _soundChannel : SoundChannel;
		private var _lastPosition : Number = 0;
		
		//--------------------------------------
		//  SIGNALS
		//--------------------------------------
		/**
		 * Dispatched when the sound begins playback 
		 */		
		public var playbackStarted : Signal = new Signal(SoundPipeItem);
		
		/**
		 * Dispatched when the sound completes playback 
		 */		
		public var playbackCompleted : Signal = new Signal(SoundPipeItem);
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor 
		 * @param p_sound
		 * @param p_soundTransform
		 * 
		 */
		public function SoundPipeItem( p_sound : Sound, p_soundTransform : SoundTransform = null )
		{
			_sound = p_sound;
			_originTransform = (p_soundTransform == null)?new SoundTransform():p_soundTransform;
		}
		
		/**
		 * Destroy the sound item 
		 * 
		 */
		public function destroy () : void
		{
			stop();
			playbackStarted.removeAll();
			playbackCompleted.removeAll();
		}
		
		/**
		 * Play the sound item 
		 * 
		 */		
		public function play () : void
		{
			destroyOldChannel();
			
			_soundChannel = _sound.play(0, 0, _originTransform);
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundPlaybackCompletedHandler);
			
			playbackStarted.dispatch(this);
		}
		
		/**
		 * Pause the sound item 
		 * @param p_instant
		 * 
		 */		
		public function pause ( p_instant : Boolean = false ) : void
		{
			var duration : Number = (p_instant)?0:.5;
			TweenLite.to(_soundChannel, duration, {volume:0, onComplete:function():void{
				_lastPosition = _soundChannel.position;
				_soundChannel.stop();
			}});
		}
		
		/**
		 * Resume the sound item 
		 * @param p_instant
		 * 
		 */		
		public function resume ( p_instant : Boolean = false ) : void
		{
			destroyOldChannel();
			
			_soundChannel = _sound.play(_lastPosition, 0, _originTransform);
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundPlaybackCompletedHandler);
			var duration : Number = (p_instant)?0:.5;
			TweenLite.to(_soundChannel, duration, {volume:_originTransform.volume});
			playbackStarted.dispatch(this);
		}
		
		/**
		 * Stop the sound item 
		 * 
		 */		
		public function stop () : void
		{
			try{
				_soundChannel.stop();
			}catch(e:Error){}
			
			_lastPosition = 0;
		}
		
		/**
		 * The current volume 
		 * @return 
		 * 
		 */		
		public function get volume () : Number
		{
			try{
				return _soundChannel.soundTransform.volume;
			}catch(e:Error){}
			
			return _originTransform.volume;
		}
		
		public function set volume ( p_volume : Number ) : void
		{
			_originTransform.volume = p_volume;
			TweenLite.to(_soundChannel, .5, {volume:_originTransform.volume});
		}
		
		//--------------------------------------
		//  PRIVATE METHODS
		//--------------------------------------
		private function destroyOldChannel () : void
		{
			try{
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundPlaybackCompletedHandler);	
			}catch(e:Error){}
			
			try{
				_soundChannel.stop();	
			}catch(e:Error){}
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		private function soundPlaybackCompletedHandler ( e : Event ) : void
		{
			playbackCompleted.dispatch(this);
		}
		
		
	}
}