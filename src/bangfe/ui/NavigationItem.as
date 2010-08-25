﻿package bangfe.ui{	import bangfe.events.BasicButtonEvent;		/**	 * Navigation Item, used with the <code>NavigationGroup</code> 	 * @author Will Zadikian	 * 	 */	public class NavigationItem extends BasicButton	{		//--------------------------------------		//  PRIVATE VARIABLES		//--------------------------------------		private var _navigationGroup : NavigationGroup;		//--------------------------------------		//  PUBLIC METHODS		//--------------------------------------				override public function destroy () : void		{			//Try to cleanup from the navigation group			try{				_navigationGroup.unregisterNavigationItem(this);			}catch(e:Error){}						super.destroy();		}				//--------------------------------------		//  ACCESSOR/MUTATOR METHODS		//--------------------------------------		/**		 * The navigation group that handles this navigation item  		 * @return 		 * 		 */		public function get navigationGroup () : NavigationGroup		{			return _navigationGroup;		}		public function set navigationGroup ( p_navigationGroup : NavigationGroup ) : void		{			try{				_navigationGroup.unregisterNavigationItem(this);			}catch(e:Error){}						_navigationGroup = p_navigationGroup;						if(_navigationGroup != null)_navigationGroup.registerNavigationItem(this);		}			}}