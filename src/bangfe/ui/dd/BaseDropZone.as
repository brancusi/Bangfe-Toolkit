﻿package bangfe.ui.dd{	import bangfe.core.CoreDisplayObject;	import bangfe.utils.DisplayObjectUtils;		import com.greensock.TweenMax;		import flash.display.DisplayObject;	import flash.display.Sprite;	import flash.geom.Rectangle;		import org.osflash.signals.Signal;		import system.data.Iterator;	import system.data.collections.ArrayCollection;	import system.data.lists.ArrayList;		/**	 * The BaseDropZone is a simple drop area for use with the <code>BaseDragDropItem</code>	 * It will catch dropped items and add them to an internal DisplayObjectContainer.	 * 	 * It tracks changes and updates positioning of managed items	 *  	 * @author Will Zadikian	 * 	 */		public class BaseDropZone extends CoreDisplayObject	{				//--------------------------------------		//  SIGNALS		//--------------------------------------		/**		 * Signal - Item added to dropzone		 * Handler must expect following params:		 * 1) BaseDragDropItem		 */				public var itemAddedSignal : Signal = new Signal(BaseDragDropItem);				/**		 * Signal - Item removed from dropzone		 * Handler must expect following params:		 * 1) BaseDragDropItem		 */				public var itemRemovedSignal : Signal = new Signal(BaseDragDropItem);				/**		 * Signal - Max child count reached for dropzone		 * Handler must expect following params:		 * 1) int		 */			public var maxChildrenReachedSignal : Signal = new Signal(int);				//--------------------------------------		//  PRIVATE VARIABLES		//--------------------------------------		private var _spaceX : Number = 5;		private var _maxChildren : Number = 3;		private var _sortedItemList : ArrayList = new ArrayList();		private var _contentContainer : Sprite = new Sprite();		//--------------------------------------		//  PUBLIC METHODS		//--------------------------------------		/**		 * This is used by a BaseDragItem. Whenever the item is over a dropzone, it will cast its shadow 		 * @param p_item		 * @return Was a shadow cast		 * 		 */		public function castShadow ( p_item : BaseDragDropItem ) : Boolean		{			if(hasReachedMaxChildren)return false;			trackItem(p_item);			return true;		}				/**		 * Add an item to the dropzone. Will be pushed to the last slot if not already being tracked via dragging 		 * @param p_item		 * @return Was the item added		 * 		 */				public function addItem ( p_item : BaseDragDropItem ) : Boolean		{			if(hasReachedMaxChildren)return false;			if(_contentContainer.contains(p_item))return false;			_contentContainer.addChild(p_item);			if(!_sortedItemList.contains(p_item))_sortedItemList.add(p_item);			reAlignCollection(p_item);						itemAddedSignal.dispatch(p_item);						checkChildCount();						return true;		}				/**		 * Remove an item from the dropzone		 * @param p_item The item to remove		 * @return Was the item removed		 * 		 */					public function removeItem ( p_item : BaseDragDropItem ) : Boolean		{			unTrackItem(p_item);			if(_contentContainer.contains(p_item))_contentContainer.removeChild(p_item);			if(_sortedItemList.contains(p_item))_sortedItemList.remove(p_item);			reAlignCollection(p_item);						itemRemovedSignal.dispatch(p_item);						checkChildCount();						return true;		}		//--------------------------------------		//  ACCESSOR/MUTATOR METHODS		//--------------------------------------		/**		 * The x space between items 		 * @return 		 * 		 */		public function get spaceX () : Number		{			return _spaceX;		}		public function set spaceX ( p_spaceX : Number) : void		{			_spaceX = p_spaceX;		}				/**		 * The maximum number of children this dropzone can manage 		 * @return 		 * 		 */				public function get maxChildren () : int		{			return _maxChildren;		}		public function set maxChildren ( p_maxChildren : int) : void		{			_maxChildren = p_maxChildren;		}				/**		 * Has the maximum number of children been reached 		 * @return 		 * 		 */				public function get hasReachedMaxChildren () : Boolean		{			return (_contentContainer.numChildren >= maxChildren);		}				/**		 * The collection of items currently being managed 		 * @return 		 * 		 */				public function get itemCollection () : ArrayList		{			return _sortedItemList;		}				//--------------------------------------		//  PROTECTED METHODS		//--------------------------------------		override protected function setGlobalDefaults():void		{			addChild(_contentContainer);		}				//--------------------------------------		//  STATE METHODS		//--------------------------------------		/**		 * Show the default state of the drop zone. The state that can accept drops 		 * 		 */		protected function showDefaultState () : void {/*Override*/}				/**		 * Show the child max reached state. The state that does not except drops 		 * 		 */				protected function showMaxReachedState () : void {/*Override*/}				//--------------------------------------		//  POSITIONING METHODS		//--------------------------------------		/**		 * Re-aligns the visible collection. This iterates through the collection and positions the items		 * @param p_activeItem The item currently being dragged or processed		 * @param p_force Should the collection realign even if nothing has changed		 * 		 */				protected function reAlignCollection ( p_activeItem : BaseDragDropItem, p_force : Boolean = false ) : void		{			if(!reSlotItem(p_activeItem) && !p_force)return;						var it : Iterator = _sortedItemList.iterator();						var nextXPosition : Number = 0;						while(it.hasNext()){				var item : BaseDragDropItem = it.next() as BaseDragDropItem;								if(!item.isDragging){					item.y = 0;					TweenMax.to(item, .1, {x:nextXPosition, overwrite:1});				}								nextXPosition = (nextXPosition + item.width + spaceX);			}		}				/**		 * Reslot the active item to its new location in the list 		 * @param p_activeItem The item being dragged or processed		 * @return Was the item successfully re-slotted		 * 		 */				private function reSlotItem ( p_activeItem : BaseDragDropItem ) : Boolean		{			var previewActiveItemPosition : Boolean = (p_activeItem.currentDropZone == this);						if(previewActiveItemPosition){				var currentIndex : int = _sortedItemList.indexOf(p_activeItem);				var projectedIndex : int = calculateCorrectIndex(p_activeItem);								if(projectedIndex != currentIndex){					_sortedItemList.remove(p_activeItem);					_sortedItemList.addAt(projectedIndex, p_activeItem);				}else{					return false;				}							}else{				_sortedItemList.remove(p_activeItem);			}						return true;		}				//--------------------------------------		//  HELPER METHODS		//--------------------------------------		/**		 * Calculates the correct index for the supplied item. 		 * @param p_activeItem The item to calcuate for		 * @return The correct index in the collection		 * 		 */				protected function calculateCorrectIndex (  p_activeItem : BaseDragDropItem ) : int		{			if(_sortedItemList.isEmpty())return _sortedItemList.size();						var it : Iterator = _sortedItemList.iterator();			var bounds : Rectangle = p_activeItem.getBounds(_contentContainer);						//Use the middle of the clip x pos			var targetXPosition : Number = bounds.x + (bounds.width/2);						while(it.hasNext()){				var item : BaseDragDropItem = it.next() as BaseDragDropItem;								//We are basically looking for the item in the collection that corresponds to the ACTIVE item's x position				if((item != p_activeItem) && itemInRange(targetXPosition, item)){					if(targetXPosition < (item.x + (item.width/2))){						return (_sortedItemList.indexOf(item));					}else{						return Math.min((_sortedItemList.indexOf(item)+1), _sortedItemList.size()-1);					}				}						}						return (_sortedItemList.contains(p_activeItem))?_sortedItemList.indexOf(p_activeItem):_sortedItemList.size();		}				/**		 * Is the supplied x position in range for the specified display object 		 * @param p_xPosition The x position to check for		 * @param p_object The item to check the x position range within		 * @return 		 * 		 */				private function itemInRange ( p_xPosition : Number, p_object : DisplayObject ) : Boolean		{			return ((p_xPosition > p_object.x) && (p_xPosition < (p_object.x + p_object.width)));		}				private function checkChildCount () : void		{			if(hasReachedMaxChildren)maxChildrenReachedSignal.dispatch(maxChildren);		}				//--------------------------------------		//  PRIVATE METHODS		//--------------------------------------		private function trackItem ( p_item : BaseDragDropItem ) : void		{			p_item.itemMovedSignal.add(processMoved);			p_item.itemDroppedSignal.add(processDropped);		}				private function unTrackItem ( p_item : BaseDragDropItem ) : void		{			p_item.itemMovedSignal.remove(processMoved);			p_item.itemDroppedSignal.remove(processDropped);		}				//--------------------------------------		//  HANDLER METHODS		//--------------------------------------		private function processMoved ( p_item : BaseDragDropItem ) : void		{			reAlignCollection(p_item);		}				private function processDropped ( p_item : BaseDragDropItem ) : void		{			if(p_item.currentDropZone != this){				removeItem(p_item);			}else{				addItem(p_item);			}						reAlignCollection(p_item, true);		}			}}