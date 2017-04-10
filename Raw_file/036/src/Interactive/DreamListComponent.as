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
				if ( this.contains(_cloud)) {
					if ( _cloud.contains(_iconListMC)) {
						_cloud.removeChild( _iconListMC );
						_iconListMC = null;
					}
					_cloud.removeEventListener("DONE", onDone);
					removeChild( _cloud );
					_cloud = null;
				}
				isVisible = false;
			}
		}
		public function addGUI():void {
			_iconListMC = new IconList();
			_cloud = new DreamPopUp();
			_cloud.x = -5;
			_cloud.y = -5;
			_iconListMC.x = 7;
			_iconListMC.y = 4;
			
			_iconListMC.gotoAndStop(strHeld);
			addChild(_cloud);

			_cloud.addEventListener("DONE", onDone);
			
			if ( _iconListMC != null ) {	
				switch(_numLabel) {
				case 0:
						_cloud.mcStop.gotoAndStop("left");
					break;
				case 1:
					_cloud.mcStop.gotoAndStop("center");
					break;
				case 2:
					_cloud.mcStop.gotoAndStop("right");
					break;
				}
			}
			isVisible = true;
		}
		
		private function onDone(e:Event):void 
		{
			_cloud.addChild( _iconListMC );
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