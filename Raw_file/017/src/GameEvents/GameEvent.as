package GameEvents
{
	import flash.events.Event;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class GameEvent extends Event
	{
		public static var ON_DONE:String = "ON_DONE";
		public static var ON_INV_SELECT:String = "ON_INV_SELECT";
		public static var TIMER_CALL_TO_ACTIVATE:String = "TIMER_CALL_TO_ACTIVATE";
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