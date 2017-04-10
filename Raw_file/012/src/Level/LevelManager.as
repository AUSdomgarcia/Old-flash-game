package Level 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import House.HouseComponent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class LevelManager extends Sprite
	{
		
		
		private var houseArray:Array = [];
		private var _houseComponent:HouseComponent;
		public var gameTimer:Timer;
		public var timerDelay:Number = 0;
		public var timerCount:Number = 0;
		public var gameTimerDelay:Number = 0;
		private var _count:Number = 0;
		
		private var _randLimit:Number = 0;
		
		//Level Reference 
		public var currentLevel:Number = 0;
		
		public function LevelManager()
		{
			trace("wait");
		}
		public function initTimer( timerDelay:Number = 0 ):void {
			gameTimer = new Timer( timerDelay );
			gameTimer.start();
			gameTimer.addEventListener( TimerEvent.TIMER, inLevelTimer );
		}
		public function gameTimerStop():void {
			gameTimer.stop();
		}
		
		public function setLevel( lvl:Number, _houseLength:Number ):void {
			var col:Number = 0; 
			var row:Number = 0;
			switch( lvl ) {
				
				case 1: //Normal
				for (var i:int = 0; i < _houseLength; i++) 
				{
					_houseComponent = new HouseComponent( false, false );
					houseArray.push( _houseComponent );
					houseArray[ i ].addHouse();
					houseArray[ i ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
					houseArray[ i ].y = ( row * 210 ) + 70;
					houseArray[ i ].addEventListener(MouseEvent.CLICK, onClick );
					addChild( houseArray[ i ] );
					col++;
					if (col > 2) { col = 0; row++; }
				}
				break;
				
				case 2: //Difficult [ with car ]
				for (var j:int = 0; j < _houseLength; j++) 
				{
					_houseComponent = new HouseComponent( false, false );
					houseArray.push( _houseComponent );
					houseArray[ j ].addHouse();
					houseArray[ j ].x = ( col * ( _houseComponent.width + 60 ) ) + 50;
					houseArray[ j ].y = ( row * 210 ) + 70;
					addChild( houseArray[ j ] );
					col++;
					if (col > 2) { col = 0; row++; }
				}
				break;
			}
		}
		
		
		
		private function onClick( e:Event ):void {
			trace( e.currentTarget.isLightOn );
			trace( e.currentTarget.isChimneyOn );
		}
		
		public function inLevelTimer( e:TimerEvent ):void {
			_count = e.currentTarget.currentCount;
			
			if( _randLimit <= 0 ){
				_randLimit = Math.floor(Math.random() * 6 ) + 6;	
			}
			_randLimit--;
			
			if ( _randLimit <=0 ) {
				trace(" Trigger an Update! ");
				
				var randomHouseNumber:Number = 0;
				randomHouseNumber = Math.floor(Math.random() * houseArray.length );
						
				houseArray[ randomHouseNumber ].isCurrentHouseLightOn( true );
				trace( "house number", randomHouseNumber );
			}	
					
			trace( _randLimit );
		}
	
		
	//end
	}
}







