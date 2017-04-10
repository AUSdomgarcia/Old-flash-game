package Interactive 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class DreamListComponent extends Sprite
	{
		private var _iconListMC:IconList;
		private var cloud:DreamPopUp;
		private var _strArrHolder:Array = [];
		public var maxNum:Number = 0;
		
		public var lvl:Number;
		public var strHeld:String;
		
		public function DreamListComponent ( _str:String ) 
		{
			_strArrHolder = _str.split("_");
			var str:String = _strArrHolder[0];
			lvl = _strArrHolder[1];
			strHeld = str;
			//trace( _str );
			
			_iconListMC = new IconList();
			_iconListMC.gotoAndStop(_str);
			addChild(_iconListMC);
		}
		public function setRandomMax( max:Number ):void {
			maxNum = max;
		}
		public function removeCloud():void {
			
		}

	//end	
	}
}