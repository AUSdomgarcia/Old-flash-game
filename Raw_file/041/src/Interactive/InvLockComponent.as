package Interactive 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class InvLockComponent extends Sprite
	{	
		public var strHeld:String;
		public var state:Number;
		public var mc:Sprite;
		
		public function InvLockComponent( _spt:Sprite, _state:Number, str:String ) 
		{
			mc = new Sprite;
			state = _state;
			strHeld = str;
			if ( state == 0 ) {
				mc.gotoAndStop(1);
			}
		}
	}

}