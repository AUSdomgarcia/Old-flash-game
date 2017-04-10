package Interactive 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author domz
	 */
	public class DreamListComponent extends Sprite
	{
		private var _iconListMC:IconList;
		private var _isOn:Boolean = false;
		public var maxNum:Number = 0;
		public var randNum:Number;
		public var strHeld:String;
		
		public var isVisible:Boolean = false;
	
		public function DreamListComponent ( _str:String ) 
		{
			var numBoolean:Number = Math.floor(Math.random() * 1);
			if ( numBoolean == 1) {
				_isOn = true;
			} else {
				_isOn = false;
			}
			strHeld = _str;
		}
		public function setRandomMax( max:Number ):void {
			maxNum = max;
			randNum = Math.floor(Math.random() * max ) + 2;
		}
		private function checker():void 
		{
			randNum--;
			if ( randNum <= 1 ) {
				if (!_isOn) {
					_isOn = true;
				} else {  
					_isOn = false;
				}
				switcher();
			}
		}
		public function removeDreamComp():void {
			if ( _iconListMC != null ) 
			{
				removeChild( _iconListMC );
				_iconListMC = null;
				isVisible = false;
			}
		}
		public function addGUI():void {
			_iconListMC = new IconList();
			_iconListMC.gotoAndStop(strHeld);
			if ( _iconListMC != null ) {
				addChild(_iconListMC);
				isVisible = true;
			}
		}
		public function switcher():void {
			if ( _isOn ) {
				addGUI();
			} else {
				removeDreamComp();
			}
			setRandomMax( maxNum );
		}
		public function update():void {
			checker();
		}
	//end
	}
}