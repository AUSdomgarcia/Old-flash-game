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
			for (var i:int = 0; i < refList.length; i++) 
			{
			trace( refList[i].state );
			}
			
		}
		
	}

}