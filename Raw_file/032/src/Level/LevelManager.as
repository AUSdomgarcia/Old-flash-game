package Level 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import House.HouseComponent;
	import Interactive.SantaClaus;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class LevelManager extends Sprite
	{	
		public var setScore:Number = 0;
		
		public var houseArray:Array = [];
		private var _houseComponent:HouseComponent;
		public var hasAtimer:Boolean = false;
		
		public var levelTimer:Timer;
		public var timerDelay:Number = 0;
	
		public var setLightOnHouse:Boolean = false;
		public var setFireOnHouse:Boolean = false;
		
		private var _randomHouseNumber:Number = 0;
		private var _randLimitLight:Number = 0;
		private var _randLimitChimney:Number = 0;
		private var _randomChimney:Number = 0
		
		public function LevelManager()
		{
			
		}
		public function removeHouse():void {
			var numLen:Number = houseArray.length;
			if ( numLen != 0) {
				for (var i:int = 0; i < numLen; i++)
				{
					houseArray[ i ].removeSelf();
					houseArray[ i ].resetDataHouse();
					houseArray[ i ].removeListener();
					houseArray[ i ].removeCompleteMC();
					houseArray[ i ].gCDreamList();
				}
			}
			
		}
		
		public function setLevel( lvl:Number ):void {
			var col:Number = 0; 
			var row:Number = 0;
			setLightOnHouse = false
			setFireOnHouse = false
			
			switch( lvl )
			{	
				case 1: /* Normal - one house only */
					hasAtimer = false;
					houseArray = new Array();	
					_houseComponent = new HouseComponent();
					
					houseArray.push( _houseComponent );
					houseArray[ 0 ].x = 290.1;
					houseArray[ 0 ].y = ( row * 210 ) + 90;
					houseArray[ 0 ].addHouse();
				break;
				
				case 2:
					hasAtimer = false;
					houseArray = new Array();
					for (var xx:int = 0; xx < 2; xx++)
					{
						_houseComponent = new HouseComponent();
						_houseComponent.houseIndex = xx;
						houseArray.push( _houseComponent );
						houseArray[ xx ].addHouse();
						houseArray[ xx ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ xx ].y = ( row * 210 ) + 90;
						col++;
						if (col > 2) { col = 0; row++; }
					}
				break;

				case 3: /* Has a timer for House light */
					houseArray = new Array();
					
					for (var xy:int = 0; xy <6; xy++)
					{
						_houseComponent = new HouseComponent();
						_houseComponent.houseIndex = xy;
						houseArray.push( _houseComponent );
						houseArray[ xy ].addHouse();
						houseArray[ xy ].hasAlightSequence = false;
						houseArray[ xy ].setMaxNumLight(5);
						houseArray[ xy ].hasAChimneySequence = false;
						houseArray[ xy ].setMaxNumChimney(5);
						houseArray[ xy ].initTimerAndSetDelayForLight = 1000;
						
						houseArray[ xy ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ xy ].y = ( row * 190 ) + 70;
						col++;
						if (col > 2) { col = 0; row++; }
					}
				break;
				
				case 4: /* Has a timer for House light and chimney */
					houseArray = new Array();
					for (var i:int = 0; i < 4; i++)
					{
						_houseComponent = new HouseComponent();
						_houseComponent.houseIndex = i;
						houseArray.push( _houseComponent );
						houseArray[ i ].addHouse();
						houseArray[ i ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ i ].y = ( row * 210 ) + 90;
						
						col++;
						if (col > 2) { col = 0; row++; }
					}
					setLightOnHouse = true;
					setFireOnHouse = true;
				break;
			}
			addItem();
		}
		private function addItem():void {
			for (var i:int = 0; i < houseArray.length; i++) 
			{
				addChild(houseArray[i]);
			}
		}
		
		
		
		/*public function set initTimerAndSetDelay( timerDelay:Number ):void {
			levelTimer = new Timer( timerDelay );
			levelTimer.addEventListener( TimerEvent.TIMER, inLevelTimer );
			levelTimer.start();
		}
		private function inLevelTimer(e:TimerEvent):void 
		{
			trace("ff");
			for (var i:int = 0; i < houseArray.length; i++) 
			{
				houseArray[i].updateForLight();
			}
		}*/
		public function gameTimerStop():void {
			levelTimer.stop();
			levelTimer.reset();
		}
		
		public function gameTimerReset():void {
			levelTimer.reset();
		}
		
		public function gameTimerStart():void {
			levelTimer.start();
		}
	//end
	}
}