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
		private var _cloud:DreamPopUp;
		private var _isOn:Boolean = false;
		public var maxNum:Number = 0;
		public var randNum:Number;
		public var strHeld:String;
		private var _numLabel:Number = 0;
		
		public var isVisible:Boolean = false;
	
		public function DreamListComponent ( _str:String , num:Number ) 
		{
			_numLabel = num;
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
			randNum = Math.floor(Math.random() * max ) + 3;
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
				if ( this.contains(_iconListMC)) {
					removeChild( _iconListMC );
					_iconListMC = null;
				}
				if (this.contains(_cloud)) {
					removeChild( _cloud );
					_cloud = null;
				}
				isVisible = false;
			}
		}
		public function addGUI():void {
			_iconListMC = new IconList();
			_cloud = new DreamPopUp();
			
			_iconListMC.gotoAndStop(strHeld);
			if ( _iconListMC != null ) {
				_cloud.x = 45;
				_cloud.y = -25;
			
			switch(_numLabel) {
			case 0:
					_cloud.gotoAndStop("left");
				break;
			case 1:
				_cloud.gotoAndStop("center");
				break;
			case 2:
				_cloud.gotoAndStop("right");
				break;
			}      
				addChild( _cloud );
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