﻿package bangfe.ui{	import bangfe.core.CoreDisplayObject;	import bangfe.utils.TextUtils;		import com.greensock.TweenLite;		import flash.display.DisplayObject;	import flash.display.Sprite;	import flash.events.MouseEvent;	import flash.text.TextField;		import org.osflash.signals.Signal;
		/**	 * BasicButton, handles selection and 	 * @author Will Zadikian	 * 	 */	public class BasicButton extends CoreDisplayObject	{				//--------------------------------------		//  STAGE INSTANCES		//--------------------------------------		public var labelField : TextField;				//--------------------------------------		//  SIGNALS		//--------------------------------------		/**		 * This signal is dispatched when this <code>BasicButton</code> is selected 		 */				public var selectedSignal : Signal = new Signal(BasicButton);				//--------------------------------------		//  PRIVATE VARIABLES		//--------------------------------------		private var _index : int;		private var _label : String = "";		private var _uid : String;		private var _isSelected : Boolean = false;		private var _isEnabled : Boolean = true;				//--------------------------------------		//  PUBLIC METHODS		//--------------------------------------				/** @inheritDoc */				override public function destroy():void		{			selectedSignal.removeAll();			super.destroy();		}				/**		 * Select this item. 		 * @param p_dispatchChange Should the change be dispatched. This is true by default		 * 		 */		public function setSelected ( p_dispatchChange : Boolean = true ) : void		{			_isSelected = true;						//Exit out if disabled			if(!isEnabled)return;						showSelectedState();			mouseEnabled = false;			if(p_dispatchChange)processSelected();		}				/**		 * Deselect this item 		 * 		 */		public function deSelect () : void		{			_isSelected = false;						//Exit out if disabled			if(!isEnabled)return;						showDefaultState();			mouseEnabled = true;		}				//--------------------------------------		//  ACCESSOR/MUTATOR METHODS		//--------------------------------------				/**		 * The uid for this button 		 * @return 		 * 		 */		public function get uid () : String		{			return _uid;		}				public function set uid ( p_uid : String ) : void		{			_uid = p_uid;		}				/**		 * The Index of this button  		 * @return 		 * 		 */		public function get index () : int		{			return _index;		}				public function set index ( p_index : int ) : void		{			_index = p_index;		}				/**		 * The Label for this button 		 * @return 		 * 		 */		public function get label () : String		{			return _label;		}				public function set label ( p_label : String ) : void		{			_label = p_label;			draw();		}				/**		 * Is this navigation item currently selected 		 * @return 		 * 		 */		public function get isSelected () : Boolean		{			return _isSelected;		}				/**		 * Is this navigation item currently enabled 		 * @return 		 * 		 */		public function get isEnabled () : Boolean		{			return _isEnabled;		}				public function set isEnabled ( p_enabled : Boolean ) : void		{			if(_isEnabled == p_enabled)return;			_isEnabled = p_enabled;						if(_isEnabled){				if(isSelected){					showSelectedState();									}else{					showDefaultState();					mouseEnabled = true;				}			}else{				showDisabledState();				mouseEnabled = false;			}		}				//--------------------------------------		//  PROTECTED METHODS		//--------------------------------------					override protected function draw():void		{			if(labelField){				if(label)labelField.text = label;			}		}				protected function showHoverState () : void		{			TweenLite.to(this, .5, {alpha:.5});		}				protected function showDefaultState () : void		{			TweenLite.to(this, .5, {alpha:1});		}				protected function showSelectedState () : void		{			TweenLite.to(this, .5, {alpha:.5});		}				protected function showDisabledState () : void		{			TweenLite.to(this, .5, {alpha:.3});		}				protected function processSelected () : void		{			//Dispatch the selected signal			selectedSignal.dispatch(this);		}				//--------------------------------------		//  PRIVATE METHODS		//--------------------------------------		override protected function setGlobalDefaults () : void		{			if(labelField)labelField.mouseEnabled = false;			tabEnabled = false;			tabChildren = false;			mouseChildren = false;			buttonMode = true;		}				override protected function addGlobalListeners () : void		{			addEventListener(MouseEvent.MOUSE_OVER, overHander, false, 0, true);			addEventListener(MouseEvent.MOUSE_OUT, outHander, false, 0, true);		}				override protected function removeGlobalListeners () : void		{			removeEventListener(MouseEvent.MOUSE_OVER, overHander);			removeEventListener(MouseEvent.MOUSE_OUT, outHander);		}				//--------------------------------------		//  HANDLER METHODS		//--------------------------------------		private function overHander ( e : MouseEvent ) : void		{			if(!isSelected && isEnabled)showHoverState();		}				private function outHander ( e : MouseEvent ) : void		{			if(!isSelected && isEnabled)showDefaultState();		}			}}