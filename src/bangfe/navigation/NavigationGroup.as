package bangfe.navigation
{
	
	import bangfe.core.ICoreObject;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	import system.data.Iterator;
	import system.data.collections.ArrayCollection;

	/**
	 * This manages navigation items. Much like a RadioButtonGroup, this
	 * handles selecting and deselecting <code>NavigationItem</code>.
	 *  
	 * @author Will Zadikian
	 * 
	 */
	public class NavigationGroup implements ICoreObject
	{
		
		//--------------------------------------
		//  SIGNALS
		//--------------------------------------
		/**
		 * The signal dispatched when a <code>NavigationItem</code> is selected. 
		 */		
		public var itemSelectedSignal : Signal = new Signal(INavigationItem);
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _selectedNavigationItem : INavigationItem;
		private var _navigationItemCollection : ArrayCollection = new ArrayCollection();
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/** @inheritDoc */		
		public function destroy () : void
		{
			clear();
			itemSelectedSignal.removeAll();
		}
		
		/**
		 * Clear out all associated items 
		 * 
		 */
		public function clear () : void
		{
			var it : Iterator = _navigationItemCollection.iterator();
			while(it.hasNext()){
				var item : INavigationItem = it.next() as INavigationItem;
				unregisterNavigationItem(item);
				_navigationItemCollection.remove(item);
			}
			
			_selectedNavigationItem = null;
		}
		
		/**
		 * Register a <code>NavigationItem</code> with this group 
		 * @param p_navigationItem
		 * 
		 */		
		public function registerNavigationItem ( p_navigationItem : INavigationItem  ) : void
		{
			if(!_navigationItemCollection.contains(p_navigationItem)){
				_navigationItemCollection.add(p_navigationItem);
				addItemListeners(p_navigationItem);
				
				//Bi-directional reflection, garantees both sides (NavigationGroup and Navigationitem)
				//have knowledge of eachother, so creation and destruction works correctly
				if(p_navigationItem.navigationGroup != this)p_navigationItem.navigationGroup = this;
			}
		}
		
		/**
		 * Register multiple <code>NavigationItem</code> instances with this <code>NavigationGroup</code> 
		 * @param p_navigationItemCollection
		 * 
		 */		
		public function registerMultipleNavigationItems ( p_navigationItemCollection : Array ) : void
		{
			for each(var item : INavigationItem  in p_navigationItemCollection){
				registerNavigationItem(item);
			}
		}
		
		/**
		 * Unregister the <code>NavigationItem</code> with this group 
		 * @param p_navigationItem
		 * 
		 */
		public function unregisterNavigationItem ( p_navigationItem : INavigationItem  ) : void
		{
			if(_navigationItemCollection.contains(p_navigationItem)){
				removeItemListeners(p_navigationItem);
				_navigationItemCollection.remove(p_navigationItem);
				
				//Bi-directional reflection, garantees both sides (NavigationGroup and Navigationitem)
				//have knowledge of eachother, so creation and destruction works correctly
				p_navigationItem.navigationGroup = null;
				
				//Reset selected nav item
				if(_selectedNavigationItem == p_navigationItem)_selectedNavigationItem = null;
			}
		}
		
		/**
		 * UnRegister multiple <code>NavigationItem</code> instances with this <code>NavigationGroup</code> 
		 * @param p_navigationItemCollection
		 * 
		 */	
		public function unregisterMultipleNavigationItems ( p_navigationItemCollection : Array ) : void
		{
			for each(var item : INavigationItem  in p_navigationItemCollection){
				unregisterNavigationItem(item);
			}
		}
		
		/**
		 * Set a specific <code>NavigationItem</code> to selected.
		 * This in turn triggers the navigation item to run its process method 
		 * @param p_navigationItem
		 * 
		 */
		public function selectNavigationItem ( p_navigationItem : INavigationItem , p_dispatchChange : Boolean = true ) : void
		{
			if(_selectedNavigationItem == p_navigationItem)return;
			
			var it : Iterator = _navigationItemCollection.iterator();
			
			while(it.hasNext()){
				var item : INavigationItem  = it.next() as INavigationItem ;
				
				if(item == p_navigationItem){
					setNavigationItemSelected(item, p_dispatchChange);
				}else{
					item.setDeSelected();
				}
			}
		}
		
		/**
		 * Set a specific <code>NavigationItem</code> to selected based on its UID property 
		 * @param p_uid UID of the item to select
		 * @param p_dispatchChange Should the change be dispatched
		 * 
		 */
		public function selectNavigationUID ( p_uid : String, p_dispatchChange : Boolean = true ) : void
		{
			if(_selectedNavigationItem != null)if(_selectedNavigationItem.uid == p_uid)return;
			
			var it : Iterator = _navigationItemCollection.iterator();
			
			while(it.hasNext()){
				var item : INavigationItem  = it.next() as INavigationItem ;
				
				if(item.uid == p_uid){
					setNavigationItemSelected(item, p_dispatchChange);
				}else{
					item.setDeSelected();
				}
			}
		}
		
		/**
		 * Set a specific <code>NavigationItem</code> to selected based on its index in the collection 
		 * @param p_uid UID of the item to select
		 * @param p_dispatchChange Should the change be dispatched
		 * 
		 */
		public function selectNavigationIndex ( p_index : int, p_dispatchChange : Boolean = true ) : void
		{
			if(_selectedNavigationItem != null)if(_navigationItemCollection.indexOf(_selectedNavigationItem) == p_index)return;
			
			var it : Iterator = _navigationItemCollection.iterator();
			
			while(it.hasNext()){
				var item : INavigationItem  = it.next() as INavigationItem ;
				var index : int = _navigationItemCollection.indexOf(item);
				
				if(index == p_index){
					setNavigationItemSelected(item, p_dispatchChange);
				}else{
					item.setDeSelected();
				}
			}
		}
		
		/**
		 * Deselect all navigation items 
		 * 
		 */		
		public function deselectAll () : void
		{
			_selectedNavigationItem = null;
			
			var it : Iterator = _navigationItemCollection.iterator();
			
			while(it.hasNext()){
				var item : INavigationItem  = it.next() as INavigationItem ;
				item.setDeSelected();
			}
		}
		
		//--------------------------------------
		//  ACCESSOR METHODS
		//--------------------------------------
		public function get selectedNavigationItem () : INavigationItem 
		{
			return _selectedNavigationItem;
		}

		//--------------------------------------
		//  PRIVATE METHODS
		//--------------------------------------
		private function addItemListeners ( p_navigationItem : INavigationItem  ) : void
		{
			p_navigationItem.selectRequesteSignal.add(navigationItemClickHandler);
		}
		
		private function removeItemListeners ( p_navigationItem : INavigationItem  ) : void
		{
			p_navigationItem.selectRequesteSignal.remove(navigationItemClickHandler);
		}
		
		private function setNavigationItemSelected ( p_navigationItem : INavigationItem , p_dispatchChange : Boolean = true) : void
		{
			if(_selectedNavigationItem == p_navigationItem)return;
			
			_selectedNavigationItem = p_navigationItem;
			_selectedNavigationItem.setSelected(p_dispatchChange);
			
			if(p_dispatchChange)itemSelectedSignal.dispatch(_selectedNavigationItem);
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		
		private function navigationItemClickHandler ( p_navigtaionItem : NavigationItem ) : void
		{
			selectNavigationItem(p_navigtaionItem);
		}
		
	}
}