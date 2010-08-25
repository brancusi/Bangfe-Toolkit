package
{

	import bangfe.core.CoreDisplayObject;
	import bangfe.display.container.TransitionContainer;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class TransitionContainerTest extends CoreDisplayObject
	{
		
		//--------------------------------------
		//  STAGE INSTANCES
		//--------------------------------------	
		public var showView1 : SimpleButton;
		public var showView2 : SimpleButton;
		public var showView3 : SimpleButton;
		
		public var removeView1 : SimpleButton;
		public var removeView2 : SimpleButton;
		public var removeView3 : SimpleButton;
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------	
		private var _transitionContainer : TransitionContainer;
		
		private var _view1 : DisplayObject;
		private var _view2 : DisplayObject;
		private var _view3 : DisplayObject;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------	
		/**
		 * Constructor 
		 * 
		 */
		public function TransitionContainerTest()
		{
			super();
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------	
		override protected function setDefaults():void
		{
			_transitionContainer = new TransitionContainer();
			addChild(_transitionContainer);
		}
		
		override protected function addListeners():void
		{
			showView1.addEventListener(MouseEvent.CLICK, showViewButtonClickHandler, false, 0, true);
			showView2.addEventListener(MouseEvent.CLICK, showViewButtonClickHandler, false, 0, true);
			showView3.addEventListener(MouseEvent.CLICK, showViewButtonClickHandler, false, 0, true);
			
			removeView1.addEventListener(MouseEvent.CLICK, removeViewButtonClickHandler, false, 0, true);
			removeView2.addEventListener(MouseEvent.CLICK, removeViewButtonClickHandler, false, 0, true);
			removeView3.addEventListener(MouseEvent.CLICK, removeViewButtonClickHandler, false, 0, true);
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------	
		private function showViewButtonClickHandler ( e : MouseEvent ) : void
		{
			switch(e.target){
				case showView1 :
					_view1 = new TestViewOne();
					_transitionContainer.addChild(_view1);			
					break;
				case showView2 :
					_view2 = new TestViewTwo();
					_transitionContainer.addChild(_view2);
					break;
				case showView3 :
					_view3 = new TestViewThree();
					_transitionContainer.addChild(_view3);
					break;
			}
		}
		
		private function removeViewButtonClickHandler ( e : MouseEvent ) : void
		{
			switch(e.target){
				case removeView1 :
					_transitionContainer.removeChild(_view1);			
					break;
				case removeView2 :
					_transitionContainer.removeChild(_view2);
					break;
				case removeView3 :
					_transitionContainer.removeChild(_view3);
					break;
				
			}
		}
		
	}
}