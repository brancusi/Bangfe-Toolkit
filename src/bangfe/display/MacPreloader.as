package bangfe.display
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class MacPreloader extends Sprite
	{
		private var _innerRadius			:uint = 6;
		private var _outerRadius			:uint = 12;
		private var _numberOfSegments		:uint = 12;
		private var _degreesPerSegment		:Number;
		private var _color					:uint = 0x666666;
		
		private var _timer					:Timer = new Timer(40, 0);
		
		/**
		 * Constrcutor 
		 * @param p_innerRadius
		 * @param p_outerRadius
		 * @param p_numberOfSegements
		 * 
		 */
		public function MacPreloader(p_innerRadius:uint = 0, p_outerRadius:uint = 0, p_numberOfSegements:uint = 0)
		{
			super();
			
			if (p_innerRadius != 0) {
				_innerRadius = p_innerRadius; 
			}
			if (p_outerRadius != 0) {
				_outerRadius = p_outerRadius; 
			}
			if (p_numberOfSegements != 0) {
				_numberOfSegments = p_numberOfSegements; 
			}
			
			_degreesPerSegment = 360 / _numberOfSegments;
			
			draw();
		}
		
		public function starSpin () : void
		{
			isSpinning = true;
		}
		
		public function stopSpin () : void
		{
			isSpinning = false;
		}
		
		/**
		 * Is the preloader spinning 
		 * @param p_boolean
		 * 
		 */
		public function set isSpinning(p_boolean:Boolean):void
		{
			switch(p_boolean) {
				case true:
					_timer.addEventListener(TimerEvent.TIMER, rotateCircle, false, 0, true);
					_timer.reset();
					_timer.start();
				break;
				case false:
					_timer.removeEventListener(TimerEvent.TIMER, rotateCircle);
					_timer.stop();
				break;
			}
		}

		private function draw():void
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
		
		
		
		private function deg2rad(deg:Number):Number
		{
			var rad:Number = deg * (Math.PI / 180);
			return rad;
		}

		private function rotateCircle(evt:TimerEvent):void{
			this.rotation += _degreesPerSegment;
		}
	}
}