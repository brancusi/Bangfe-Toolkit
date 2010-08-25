package bangfe.simpleaudioplayer
{
	import com.greensock.TweenMax;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.VolumePlugin;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * Simple audio player. Toggle and volume. Great for background music
	 * @author Will Zadikian
	 * 
	 */	
	public class SimpleAudioPlayer extends MovieClip
	{
		
		//--------------------------------------
		//  PROTECTED VARIABLES
		//--------------------------------------
		protected var _source : String;
		
		protected var _soundChannel : SoundChannel;
		protected var _transform : SoundTransform;
		protected var _sound : Sound;
		protected var _volume : Number = .8;
		
		protected var _lastPositon : Number = 0;
		protected var _isPlaying : Boolean = false;
		protected var _isManualPause : Boolean = false;
		protected var _isInitialized : Boolean = false;
		protected var _isTransitioning : Boolean = false;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * Constructor 
		 * 
		 */		
		public function SimpleAudioPlayer()
		{
			init();
		}
		
		public function destroy () : void
		{
			removeListeners();
			killAllSounds();
		}
		
		/**
		 * Toggle audio play/pause
		 * 
		 */		
		public function toggle () : void
		{
			if(isPlaying){
				pause(true);
			}else{
				resume(true);
			}
		}
		
		/**
		 * Pause audio
		 * @param p_manualPause
		 * 
		 */		
		public function pause ( p_manualPause : Boolean = false ) : void
		{
			if(!_source)return;
			
			if(!isInitialized)return;
			
			if(!isPlaying)return;
			
			if(isTransitioning)return;
			
			if(_soundChannel == null)return;
			
			_lastPositon = _soundChannel.position;
	
			isTransitioning = true;
			
			if(p_manualPause)isManualPause = p_manualPause;
			
			isPlaying = false;
			
			TweenMax.to(_soundChannel, 1, {volume:0, onComplete:pauseComplete});
		}
		
		/**
		 * Resume audio 
		 * @param p_manualResume
		 * 
		 */		
		public function resume ( p_manualResume : Boolean = false ) : void
		{
			if(!_source)return;
			
			if(!isInitialized)return;
			
			if(isPlaying)return;
			
			if(isTransitioning)return;
			
			if(p_manualResume)isManualPause = false;
			
			if(isManualPause)return;
			
			if(_sound){
				try{
					_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler, false);
				}catch(e:Error){}
				
				isTransitioning = true;
				
				_soundChannel = _sound.play(_lastPositon, 0, new SoundTransform(0));
				
				_lastPositon = 0;
				
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler, false, 0, true);

				TweenMax.to(_soundChannel, 1, {volume:_volume, onComplete:resumeComplete});
			}
		}
		
		/**
		 * Show UI Controls
		 * 
		 */		
		public function show () : void
		{
			TweenMax.to(this, .5, {autoAlpha:1});
		}
		
		/**
		 * Hide UI Controls 
		 * 
		 */		
		public function hide () : void
		{
			TweenMax.to(this, .5, {autoAlpha:0});
		}
		
		
		//--------------------------------------
		//  ACCESSOR METHODS
		//--------------------------------------
		
		/**
		 * Source url for current audio 
		 * @return 
		 * 
		 */		
		public function get source () : String 
		{
			return _source; 
		}

		public function set source ( p_source : String ) : void 
		{ 
			if(_source == p_source)return;
			_source = p_source;
			loadMusic();
		}
		
		/**
		 * Volume of audio 
		 * @return 
		 * 
		 */		
		public function get volume () : Number 
		{
			return _volume; 
		}

		public function set volume ( p_volume : Number ) : void 
		{
			_volume = p_volume;
			if(_soundChannel && isPlaying)TweenMax.to(_soundChannel, 1, {volume:_volume});
		}
		
		/**
		 * Is the audio player currently playing 
		 * @return 
		 * 
		 */		
		public function get isPlaying () : Boolean 
		{
			return _isPlaying; 
		}

		public function set isPlaying ( p_isPlaying : Boolean ) : void 
		{ 
			_isPlaying = p_isPlaying;
			draw();
		}
		
		/**
		 * Is the audio player transitioning between resume/pause 
		 * @return 
		 * 
		 */		
		public function get isTransitioning () : Boolean 
		{
			return _isTransitioning; 
		}

		public function set isTransitioning ( p_isTransitioning : Boolean ) : void 
		{ 
			_isTransitioning = p_isTransitioning; 
		}
		
		/**
		 * Has the audio player been manually paused 
		 * @return 
		 * 
		 */		
		public function get isManualPause () : Boolean 
		{
			return _isManualPause; 
		}

		public function set isManualPause ( p_isManualPause : Boolean ) : void 
		{ 
			_isManualPause = p_isManualPause; 
		}
		
		/**
		 * Has the audio player been initialized 
		 * @return 
		 * 
		 */		
		public function get isInitialized () : Boolean 
		{
			return _isInitialized; 
		}

		public function set isInitialized ( p_isInitialized : Boolean ) : void 
		{ 
			_isInitialized = p_isInitialized; 
		}
		
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		protected function init () : void
		{
			setDefaults();
			addListeners();
			
			isInitialized = true;
		}
		
		protected function setDefaults():void
		{
		
			TweenPlugin.activate([AutoAlphaPlugin, VolumePlugin]);
			
			this.alpha = 1;
			
			this.mouseChildren = false;
			this.buttonMode = true;
			
			_sound = new Sound();
            _sound.addEventListener(Event.ID3, id3Handler);
            _sound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            _sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            
			_transform = new SoundTransform(_volume);
		}
		
		protected function addListeners () : void
		{
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);
		}
		
		protected function removeListeners () : void
		{
			this.removeEventListener(MouseEvent.CLICK, clickHandler, false);
			this.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false);
			this.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false);
			
			try{
				_sound.removeEventListener(Event.ID3, id3Handler);
           		_sound.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            	_sound.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			}catch(e:Error){}	
		}
		
		protected function loadMusic () : void
		{
			killAllSounds();
			var request:URLRequest = new URLRequest(_source);
            _sound.load(request);
            resume();
		}
		
		protected function pauseComplete () : void
		{
			recordAndKillSound();
			isTransitioning = false;
			isPlaying = false;
		}
		
		protected function resumeComplete () : void
		{
			isTransitioning = false;
			isPlaying = true;
		}
		
		protected function recordAndKillSound () : void
		{
			killAllSounds();	
		}
		
		protected function killAllSounds () : void
		{			
			try{
				_soundChannel.stop();
				_soundChannel = null;
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler, false);
			}catch(e:Error){}
		}
		
		protected function draw () : void
		{
			//Override
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		protected function clickHandler ( e : MouseEvent ) : void
		{
			toggle();
		}
		
		protected function mouseOverHandler ( e : MouseEvent ) : void
		{
			//Override
		}
		
		protected function mouseOutHandler ( e : MouseEvent ) : void
		{
			//Override
		}

        protected function soundCompleteHandler(event:Event):void {
			isPlaying = false;
			isTransitioning = false;
			resume();
        }

        protected function id3Handler(event:Event):void {
            //trace("id3Handler: " + event);
        }

        protected function ioErrorHandler(event:Event):void {
            //trace("ioErrorHandler: " + event);
        }

        protected function progressHandler(event:ProgressEvent):void {
            //trace("progressHandler: " + event);
        }
		
	}
}