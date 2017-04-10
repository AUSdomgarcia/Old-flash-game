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
		public var houseArray:Array = [];
		private var _houseComponent:HouseComponent;
		
		public var levelTimer:Timer;
		public var timerDelay:Number = 0;
		public var timerCount:Number = 0;
		public var gameTimerDelay:Number = 0;
	
		public var setLightOnHouse:Boolean = false;
		public var setFireOnHouse:Boolean = false;
		
		private var _randomHouseNumber:Number = 0;
		private var _randLimitLight:Number = 0;
		private var _randLimitChimney:Number = 0;
		private var _randomChimney:Number = 0;
		
		//Level Reference 
		public var currentLevel:Number = 0;
		
		public function LevelManager()
		{
			
		}
		public function initTimer( timerDelay:Number = 0 ):void {
			levelTimer = new Timer( timerDelay );
			levelTimer.addEventListener( TimerEvent.TIMER, inLevelTimer );
			levelTimer.start();
		}
		public function gameTimerStop():void {
			levelTimer.stop();
		}
		public function gameTimerStart():void {
			levelTimer.start();
		}
		
		private function addItem():void {
			for (var i:int = 0; i < houseArray.length; i++) 
			{
				addChild(houseArray[i]);
			}
		}
		
		public function inLevelTimer( e:TimerEvent ):void {
			//trace("timer:", e.target.currentCount);
			setLightSequence();
			setChimneySequence();
			
		}
		
		//LIGHT HOUSE RANDOM NUMBER
		private function setLightSequence():void {
			if ( setLightOnHouse ) {
				if( _randLimitLight <= 0 ){
					_randLimitLight = Math.floor(Math.random() * 10 ) + 8;
				}
					
				if ( _randLimitLight <= 1 ) {
					_randomHouseNumber = Math.floor(Math.random() * houseArray.length );
					if ( houseArray[ _randomHouseNumber ].isLightOn != true ) {
						houseArray[ _randomHouseNumber ].isCurrentHouseLightOn( true );
					} else { houseArray[ _randomHouseNumber ].isCurrentHouseLightOn( false ); 
								if ( houseArray[ _randomHouseNumber ].isChimneyOn ) {
									houseArray[ _randomHouseNumber ].isCurrentChimneyLightOn( false );
								}  
							}
				}
			}
			_randLimitLight--;
			//trace("LIGHT HOUSE RANDOM NUMBER: ", _randLimitLight, _randomHouseNumber );
		}
		
		private function setChimneySequence():void {
			if ( setFireOnHouse )
			{
				if( _randLimitChimney <= 0 ){
					_randLimitChimney = Math.floor(Math.random() * 3 ) + 3;
				}
				if ( _randLimitChimney <= 1 ) {
				_randomChimney = Math.floor(Math.random() * houseArray.length );
				}				
				if ( houseArray[ _randomChimney ].isLightOn == true ) {
					houseArray[ _randomChimney ].isCurrentChimneyLightOn( true );
				}	
				if ( _randLimitChimney <= 1 || houseArray[ _randomChimney ].isLightOn != true ) {
						houseArray[ _randomChimney ].isCurrentChimneyLightOn( false );
					}
			_randLimitChimney--;
			}
		}
		
		
		
		
		/* SET UP LEVEL 
		 * 10 LEVEL WERE ADDED 
		*/
		public function setLevel( lvl:Number, _houseLength:Number ):void {
			var col:Number = 0; 
			var row:Number = 0;
			setLightOnHouse = false
			setFireOnHouse = false
			
			switch( lvl )
			{	
				case 1: /* Normal - one house only */
					houseArray = new Array();	
					_houseComponent = new HouseComponent( false, false );
					
					houseArray.push( _houseComponent );
					houseArray[ 0 ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
					houseArray[ 0 ].y = ( row * 210 ) + 90;
					houseArray[ 0 ].addHouse();
					
				break;
				
				case 2: /* Has a timer for House light */
					houseArray = new Array();
					for (var xx:int = 0; xx < 2; xx++)
					{
						_houseComponent = new HouseComponent( false, false );
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
					initTimer(800);
					for (var xy:int = 0; xy < _houseLength; xy++)
					{
						_houseComponent = new HouseComponent( false, false );
						_houseComponent.houseIndex = xy;
						houseArray.push( _houseComponent );
						houseArray[ xy ].addHouse();
						houseArray[ xy ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ xy ].y = ( row * 210 ) + 90;
						
						col++;
						if (col > 2) { col = 0; row++; }
						setLightOnHouse = true;
					}
				break;
				
				case 4: /* Has a timer for House light and chimney */
				houseArray = new Array();
					initTimer(200);
					for (var i:int = 0; i < _houseLength; i++)
					{
						_houseComponent = new HouseComponent( false, false );
						_houseComponent.houseIndex = i;
						houseArray.push( _houseComponent );
						houseArray[ i ].addHouse();
						houseArray[ i ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ i ].y = ( row * 210 ) + 90;
						
						col++;
						if (col > 2) { col = 0; row++; }
						setLightOnHouse = true;
						setFireOnHouse = true;
					}
				break;
				
				
				case 5: //Difficult [ with car ]

					for (var j:int = 0; j < _houseLength; j++) 
					{
						_houseComponent = new HouseComponent( false, false );
						houseArray.push( _houseComponent );
						houseArray[ j ].addHouse();
						houseArray[ j ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
						houseArray[ j ].y = ( row * 210 ) + 90;
						addChild( houseArray[ j ] );
						col++;
						if (col > 2) { col = 0; row++; }
					}
				break;
			}
			addItem();
		}	
	//end
	}
}