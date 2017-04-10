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
					houseArray[ i ].resetDataHouse();
					houseArray[ i ].removeListener();
					houseArray[ i ].removeCompleteMC();
					houseArray[ i ].gCDreamList();
					houseArray[ i ].removeSelf();
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
					houseArray = new Array();	
					_houseComponent = new HouseComponent();
					
					houseArray.push( _houseComponent );
					houseArray[ 0 ].addHouse();
					houseArray[ 0 ].initTimerAndSetDelayForLight = 1000;
					houseArray[ 0 ].x = 270.1;
					houseArray[ 0 ].y = ( row * 210 ) + 90;
					
				break;
				
				case 2:
					houseArray = new Array();
					
					for (var aa:int = 0;aa <2; aa++)
					{
						_houseComponent = new HouseComponent();
						_houseComponent.houseIndex = aa;
						houseArray.push( _houseComponent );
						houseArray[ aa ].addHouse();
						
						houseArray[ aa ].initTimerAndSetDelayForLight = 1000;
						houseArray[ aa ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ aa ].y = ( row * 190 ) + 70;
						col++;
						if (col > 2) { col = 0; row++; }
					}
				break;

				case 3:
					houseArray = new Array();
					
					for (var bb:int = 0; bb <3; bb++)
					{
						_houseComponent = new HouseComponent();
						_houseComponent.houseIndex = bb;
						houseArray.push( _houseComponent );
						houseArray[ bb ].addHouse();
						houseArray[ bb ].initTimerAndSetDelayForLight = 1000;
						houseArray[ bb ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ bb ].y = ( row * 190 ) + 70;
						col++;
						if (col > 2) { col = 0; row++; }
					}
				break;
				
				case 4:
					houseArray = new Array();
					
					for (var cc:int = 0; cc <4; cc++)
					{
						_houseComponent = new HouseComponent();
						_houseComponent.houseIndex = cc;
						houseArray.push( _houseComponent );
						houseArray[ cc ].addHouse();
						
						houseArray[ cc ].initTimerAndSetDelayForLight = 1000;
						houseArray[ cc ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ cc ].y = ( row * 190 ) + 70;
						col++;
						if (col > 2) { col = 0; row++; }
					}
				break;
				
				case 5: /* Has a timer for House light */
					houseArray = new Array();
					
					for (var dd:int = 0; dd <3; dd++)
					{
						_houseComponent = new HouseComponent();
						_houseComponent.houseIndex = dd;
						houseArray.push( _houseComponent );
						houseArray[ dd ].addHouse();
						
						houseArray[ dd ].initTimerAndSetDelayForLight = 1000;
						houseArray[ dd ].hasAlightSequence = true;
						houseArray[ dd ].setMaxNumLight(2);
						houseArray[ dd ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ dd ].y = ( row * 190 ) + 70;
						col++;
						if (col > 2) { col = 0; row++; }
					}
				break;
				
				case 6: /* Has a timer for House light and chimney */
					houseArray = new Array();
					
					for (var ee:int = 0; ee <4; ee++)
					{
						_houseComponent = new HouseComponent();
						_houseComponent.houseIndex = ee;
						houseArray.push( _houseComponent );
						houseArray[ ee ].addHouse();
						
						houseArray[ ee ].initTimerAndSetDelayForLight = 1000;
						houseArray[ ee ].hasAlightSequence = true;
						houseArray[ ee ].setMaxNumLight(5);
						
						houseArray[ ee ].hasAChimneySequence = true;
						houseArray[ ee ].setMaxNumChimney(5);
						houseArray[ ee ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ ee ].y = ( row * 190 ) + 70;
						col++;
						if (col > 2) { col = 0; row++; }
					}
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