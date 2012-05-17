package bangfe.display
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	/**
	 * Simple infinite spinner
	 * @author Josh Feldman
	 * 
	 */	
	public class InfiniteSpinner extends Sprite
	{
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _innerRadius			:uint = 6;
		private var _outerRadius			:uint = 12;
		private var _numberOfSegments		:uint = 12;
		private var _degreesPerSegment		:Number;
		private var _color					:uint = 0x666666;
		
		private var _timer					:Timer = new Timer(40, 0);
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constrcutor 
		 * @param p_innerRadius
		 * @param p_outerRadius
		 * @param p_numberOfSegements
		 * 
		 */
		public function InfiniteSpinner(p_innerRadius:uint = 6, p_outerRadius:uint = 12, p_numberOfSegements:uint = 12)
		{
			this.visible = false;
			this.alpha = 0;
			
			_innerRadius = p_innerRadius; 
			_outerRadius = p_outerRadius; 
			_numberOfSegments = p_numberOfSegements; 
			
			_degreesPerSegment = 360 / _numberOfSegments;
			
			draw();
		}
			
		public function startSpin () : void
		{
			addEventListener(Event.ENTER_FRAME, rotateCircle, false, 0, true);
			TweenMax.to(this, .25, {autoAlpha:1});
		}
		
		public function stopSpin () : void
		{
			TweenMax.to(this, .25, {autoAlpha:0, onComplete:function():void{
				removeEventListener(Event.ENTER_FRAME, rotateCircle);
			}});
		}
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------
		public function get innerRadius () : uint 
		{
			return _innerRadius;
		}
		
		public function set innerRadius ( p_innerRadius : uint ) : void
		{
			_innerRadius = p_innerRadius;
			draw();
		}
		
		public function get outerRadius () : uint 
		{
			return _outerRadius;
		}
		
		public function set outerRadius ( p_outerRadius : uint ) : void
		{
			_outerRadius = p_outerRadius;
			draw();
		}
		
		public function get numberOfSegments () : uint 
		{
			return _numberOfSegments;
		}
		
		public function set numberOfSegments ( p_numberOfSegments : uint ) : void
		{
			_numberOfSegments = p_numberOfSegments;
			_degreesPerSegment = 360 / _numberOfSegments;
			draw();
		}
		
		public function get color () : Number 
		{
			return _color;
		}
		
		public function set color ( p_color : Number ) : void
		{
			_color = p_color;
			draw();
		}
		
		//--------------------------------------
		//  PRIVATE METHODS
		//--------------------------------------
		private function draw () : void
		{
			this.graphics.clear();
			
			var center		:Point = new Point(0,0);
			var startPos	:Point = new Point();
			startPos.x = center.x + _innerRadius * Math.cos( deg2rad(360) );
			startPos.y = center.y + _innerRadius * Math.sin( deg2rad(360) );
			
			this.graphics.moveTo(startPos.x, startPos.y);
			
			for (var deg:Number = 360; deg >= 0; deg -= _degreesPerSegment) {
				var innerPos:Point = new Point();
					innerPos.x = center.x + _innerRadius * Math.cos( deg2rad(deg) );
					innerPos.y = center.y + _innerRadius * Math.sin( deg2rad(deg) );
				
				var outerPos:Point = new Point();
					outerPos.x = center.x + _outerRadius * Math.cos( deg2rad(deg) );
					outerPos.y = center.y + _outerRadius * Math.sin( deg2rad(deg) );
				
				this.graphics.lineStyle(2, _color, (deg/360));
				this.graphics.moveTo(innerPos.x, innerPos.y);
				this.graphics.lineTo(outerPos.x, outerPos.y);
			}
		}
		
		private function deg2rad ( deg : Number ) : Number
		{
			var rad:Number = deg * (Math.PI / 180);
			return rad;
		}

		private function rotateCircle ( e : Event ) : void
		{
			this.rotation += _degreesPerSegment;
		}
	}
}