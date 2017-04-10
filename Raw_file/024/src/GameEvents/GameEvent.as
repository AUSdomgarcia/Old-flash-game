package GameEvents
{
	import flash.events.Event;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class GameEvent extends Event
	{
		public static var ON_INV_DONE:String = "ON_INV_DONE";
		public static var ON_INV_SELECT:String = "ON_INV_SELECT";
		public static var ON_INV_RESET:String = "ON_INV_RESET";
		public static var ON_LVLMANAGER_HOUSE_ACTIVATE:String = "ON_LVLMANAGER_HOUSE_ACTIVATE";
		public static var ON_CHARDATALVL_UPDATE:String = "ON_CHARDATALVL_UPDATE";
		
		public static var ON_ELF_JUMP_DONE:String = "ON_ELF_JUMP_DONE";
		public static var ON_ELF_IDLE_DONE:String = "ON_ELF_IDLE_DONE";
		
		public static var ON_BONUS_CLICK:String = "ON_BONUS_CLICK";
		
		//pop up to mapmanager
		public static var ON_POPUP_CLICK_DONE:String = "ON_POPUP_CLICK_DONE";
		//reward to mapmanager
		public static var ON_CURRPOINT_UPDATE:String = "ON_CURRPOINT_UPDATE";
		public static var ON_SANTA_JUMP_DONE:String = "ON_SANTA_JUMP_DONE";
		public static var ADD_DATA_TO_INV:String = "ADD_DATA_TO_INV";
		
		public var params:Object = new Object();
		
		public function GameEvent(type:String, _params:Object=null, bubbles:Boolean=false, cancelable:Boolean=false  ) 
		{ 
			params = _params;
			super(type, bubbles, cancelable);
		}
		
		
		public override function clone():Event 
		{ 
			return new GameEvent(type, bubbles, cancelable);
		}
		//trace("timer:");
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	//end
	}
}