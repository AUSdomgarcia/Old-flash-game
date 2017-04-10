package Interactive 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class IconComponent extends Sprite
	{
		public var isUnlock:Boolean = true;
		public var iconStr:String;
		private var _mc:IconList;
		private var iconText:String;
		
		public var label:String;
		public var state:Number;
		
		public function IconComponent( /*str:String*/ index:Number, _state:Number, _label:String )
		{
			_mc = new IconList();
			_mc.gotoAndStop( index );
			//_mc.iconTxt.text = label;
			
			label = _label;
			state = _state;
			
			switch( state ) {
				case 0:
					_mc.alpha = .50;
					isUnlock = true;
				break;
				case 1:
					iconStr = label;
					isUnlock = false;
				break;
			}
			addChild(_mc);
		}
	//end	
	}
}