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
		public var lvl:Number;
		public var str:String;
		
		public function DreamListComponent ( _str:String ) 
		{
			_strArrHolder = _str.split("_");
			str = _strArrHolder[1];
			lvl = _strArrHolder[1];
			trace( _str );
			
			_iconListMC = new IconList();
			_iconListMC.gotoAndStop(_str);
			addChild(_iconListMC);
		}
		
		public function removeCloud():void {
		
		}

	//end	
	}
}