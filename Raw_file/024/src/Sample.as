package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class Sample extends Sprite
	{
		public var refList:Array = [ { state: 0, text: "toy" },
									 { state: 1, text: "toy" },
									 { state: 2, text: "toy" },
									 { state: 3, text: "toy" },
									 { state: 4, text: "toy" } 
								   ];
		public function Sample() 
		{
			for (var i:int = refList.length ; i >= 0; i--) 
			{
				refList.pop();
			}
			trace( refList.length );
		}
	}

}
/*
 * //var mem:MemoryProfiler = new MemoryProfiler();
			//addChild(mem);
			//mem.x = GameConfig.GAME_WIDTH - mem.width;
			//var frame:FrameRateViewer = new FrameRateViewer();
			//addChild(frame);
 * */
/*package GameEvents
{
	import flash.events.Event;
	public class GameEvent extends Event
	{
		public static var ON_DONE:String = "ON_DONE";
		public static var ON_INV_SELECT:String = "ON_INV_SELECT";
		
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
		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*public function set obj(value:Object):void 
		{
			_obj = value;
		}
		public function get obj():Object 
		{
			return _obj;
		}
	//end
	}
}*/