﻿package bangfe.ui.dd{	import bangfe.core.CoreDisplayObject;	import bangfe.utils.DisplayObjectUtils;		import com.greensock.TweenMax;		import flash.events.MouseEvent;	import flash.geom.Point;		import org.osflash.signals.Signal;		/**	 * This is the base drag drop item needed by the <code>BaseDropZone</code>	 * It manages state and dragging logic.	 *  	 * @author Will Zadikian	 * 	 */	public class BaseDragDropItem extends CoreDisplayObject	{				//--------------------------------------		//  PUBLIC STATIC CONSTANTS		//--------------------------------------		public static const DEFAULT_STATE : String = "__defaultState__";		public static const DRAG_STATE : String = "__dragState__";		public static const ADD_STATE : String = "__addState__";		public static const REMOVE_STATE : String = "__removeState__";				//--------------------------------------		//  SIGNALS		//--------------------------------------		public var itemMovedSignal : Signal = new Signal(BaseDragDropItem);		public var itemDroppedSignal : Signal = new Signal(BaseDragDropItem);				//--------------------------------------		//  PRIVATE VARIABLES		//--------------------------------------		private var _isDragging : Boolean = false;		private var _lastKnowPosition : Point;		private var _state : String = DEFAULT_STATE;				//--------------------------------------		//  PUBLIC METHODS		//--------------------------------------		/**		 * Makes sure to process the drop if destroy is called and then continue with		 * normal destroy logic 		 * 		 */		override public function destroy():void		{			//Destroy all signals			itemMovedSignal.removeAll();			itemDroppedSignal.removeAll();						super.destroy();		}				/**		 * Start dragging this item.  		 * 		 */		public function startDragItem () : void		{			//Set position for the return home			_lastKnowPosition = new Point(this.x, this.y);						//Set drag state			_isDragging = true;						//Send this item to the top			DisplayObjectUtils.sendToFront(this);						//Setup the drag related listeners			addDragListeners();						//Preset the position for this drag item. Make sure the item is under the mouse			this.x = parent.mouseX - (this.width/2);			this.y = parent.mouseY - (this.height/2);						//Start the drag			this.startDrag(false);		}				//--------------------------------------		//  ACCESSOR/MUTATOR METHODS		//--------------------------------------		/**		 * Is the item currently being dragged 		 * @return 		 * 		 */				public function get isDragging () : Boolean		{			return _isDragging;		}				/**		 * Is this item currently managed by a DropZone 		 * @return 		 * 		 */				public function get isManaged () : Boolean		{			return DisplayObjectUtils.getParentWithDefinition(this, BaseDropZone);		}				/**		 * The current DropZone if the item were dropped right now 		 * @return 		 * 		 */				public function get currentDropZone () : BaseDropZone		{			return DisplayObjectUtils.getParentWithDefinition(dropTarget, BaseDropZone);		}				/**		 * Does this drop item have a potential dropzone to cast a shadow on 		 * @return 		 * 		 */				public function get hasPotentialDropZone () : Boolean		{			return (currentDropZone != null);		}				/**		 * The current state of the item 		 * @return 		 * 		 */				public function get state () : String		{			return _state;		}				public function set state ( p_state : String) : void		{			if(_state == p_state)return;						_state = p_state;						switch(_state){				case DEFAULT_STATE :					showDefaultState()					break				case DRAG_STATE :					showDragState()					break				case ADD_STATE :					showAddState()					break				case REMOVE_STATE :					showRemoveState()					break			}		}		//--------------------------------------		//  PROTECTED METHODS		//--------------------------------------		override protected function setGlobalDefaults():void		{			//Make sure to keep this in any override in order to not destroy when re-parenting			autoDestroy = false;		}				override protected function addGlobalListeners():void		{			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);		}				override protected function removeGlobalListeners():void		{			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);		}				//--------------------------------------		//  STATE METHODS		//--------------------------------------		/**		 * Show the default state. The state in which the item is not being dragged 		 */		protected function showDefaultState () : void {/*Override*/}				/**		 * Show the drag state. The state in which the item is being dragged 		 */		protected function showDragState () : void {/*Override*/}				/**		 * Show the add state. The state in which the item will be added to a dropzone 		 */		protected function showAddState () : void {/*Override*/}				/**		 * Show the remove state. The state in which the item will be removed from a dropzone.		 * This only occurs if the item is being managed by a dropzone. Not when it has cast a shadow		 * but not yet dropped 		 */		protected function showRemoveState () : void {/*Override*/}				/**		 * When an item has not yet been added to a dropzone, this will be called when the item is dropped		 * over the void and will return to its last known position 		 * 		 */				protected function returnHome () : void		{			TweenMax.to(this, .25, {x:_lastKnowPosition.x, y:_lastKnowPosition.y, onComplete:destroy});		}				//--------------------------------------		//  PRIVATE METHODS		//--------------------------------------		//This is not public in order to make sure the correct 		//processes take place when the user stops the drag.		private function stopDragItem () : void		{			_isDragging = false;						removeDragListeners();			this.stopDrag();		}				private function addDragListeners () : void		{			if(!stage)return;			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false, 0, true);		}				private function removeDragListeners () : void		{			try{				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);			}catch(e:Error){}						removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);		}				private function calculateState () : void		{			if(!isDragging){				state = DEFAULT_STATE;				return;			}							if(isManaged && hasPotentialDropZone){				state = DRAG_STATE;				return;			}						if(!isManaged && !hasPotentialDropZone){				state = DRAG_STATE;				return;			}						if(!isManaged && hasPotentialDropZone){				state = ADD_STATE;				return;			}						if(isManaged && !hasPotentialDropZone){				state = REMOVE_STATE;				return;			}		}				private function processMove () : void		{			if(currentDropZone){				currentDropZone.castShadow(this);			}						calculateState();						itemMovedSignal.dispatch(this);		}				private function processDrop () : void		{			stopDragItem();			itemDroppedSignal.dispatch(this);						if(!isManaged)returnHome();		}				//--------------------------------------		//  HANDLER METHODS		//--------------------------------------		private function mouseDownHandler ( e : MouseEvent ) : void		{			startDragItem();		}				private function mouseUpHandler ( e : MouseEvent ) : void		{			processDrop();		}				private function mouseMoveHandler ( e : MouseEvent ) : void		{			processMove();		}			}}