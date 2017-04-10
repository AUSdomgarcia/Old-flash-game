package Interactive 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import GameEvents.GameEvent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class DreamListManager extends Sprite
	{
		//External sorted
		public var houseRefArr:Array = [];
		public var randomItemArr:Array = [];
		
		private var _dreamListArray:Array = [];
		private var randomNum:Number = 0;
		private var dreamLTimer:Timer;
		public var timerDelay:Number = 800;
		
		private var _dreamList:DreamListComponent;
		public var arrDreamList:Array = [];
		
		private var _randNum:Number = 0;
			
		public function DreamListManager() 
		{
			dreamLTimer = new Timer( timerDelay );
			dreamLTimer.addEventListener( TimerEvent.TIMER, starDistribution );
		}
		
		private function starDistribution(e:TimerEvent):void 
		{
			
		}
		
		public function resetTime():void {
			dreamLTimer.reset();
		}
		public function stopTimer():void {
			dreamLTimer.stop();
		}
		
		public function startTime():void {
			dreamLTimer.start();
		}
		
		public function setArrRef( arrHouse:Array, arrItem:Array ):void {
			_dreamListArray = new Array();
			houseRefArr = arrHouse;			
			randomItemArr = arrItem;
			
			trace(this, "ArrItem:", arrItem.length, "ArrHouse.Length", arrHouse.length);
			generateDreamComponent();
		}
		
		private function generateDreamComponent():void
		{
			for (var l:int = 0; l < randomItemArr.length; l++) 
			{
				setToHouseArr( randomItemArr[l] );
			}
			
			this.parent.dispatchEvent( new GameEvent(GameEvent.ON_LVLMANAGER_HOUSE_ACTIVATE ));
			
			//HouseArray Reference this.parent
			/*for (var j:int = 0; j < houseRefArr.length; j++) 
			{
				trace("houseArrayEach", houseRefArr[j].x);
			}
			
			var comp:DreamListComponent;
			var arrH:Array = [];
			
			for (var i:int = 0; i < houseRefArr.length; i++) 
			{
				//trace(houseRefArr[i].heldDreamListArr.length);
				arrH = new Array();
				for (var j:int = 0; j < houseRefArr[i].heldDreamListArr.length; j++) 
				{
					trace(i + " " + houseRefArr[i].heldDreamListArr[j] );
					comp = new DreamListComponent( houseRefArr[i].heldDreamListArr[j] );
					arrH[i] = comp; arnold bakla
				}
				arrH[i].x = houseRefArr[i].x + ( 10 * i );
				
				addChild( arrH[i] );
			}
			
			trace(_dreamListArray[l] );
			for (var i:int = 0; i < randomItemArr.length; i++)
			{
				_dreamList = new DreamListComponent( randomItemArr[i] );
				_dreamListArray[i] = _dreamList;
				_dreamListArray[i].x = 90 * i;
				addChild( _dreamListArray[i] );
				_dreamListArray[i].setRandomMax( randomNum );
			}
			
			trace("ss", randomItemArr.length);
			var numLen:Number = _dreamListArray.length;
			trace("ss", _dreamListArray.length );
			*/
		}
		
		private function setToHouseArr( str:String ):void 
		{
			var num:Number = Math.floor(Math.random() * houseRefArr.length);
			if ( houseRefArr[num].heldDreamListArr.length != 2) {
				houseRefArr[num].heldDreamListArr.push( str );
			} else { 
				for (var i:int = 0; i < houseRefArr.length; i++) 
				{
					if (houseRefArr[i].heldDreamListArr.length != 2) {
						houseRefArr[i].heldDreamListArr.push( str );
					}
				}			        
			} 
		}
		
		private function notInclude():void{
			/*for (var j:int = 0; j < numLen; j++)
			{
				var num:Number = Math.floor( Math.random() * houseRefArr.length );
				houseRefArr[num].heldDreamListArr.push( _dreamListArray.splice( j, 1 ));
				numLen--;
			}
			trace( _dreamListArray.length );
			*/
		/*	for (var k:int = 0; k < _dreamListArray.length; k++) 
			{
				var num:Number = Math.floor( Math.random() * _dreamListArray.length );
				houseRefArr[k].heldDreamListArr.push( _dreamListArray.splice( num, 1 ));
				if ( _dreamListArray.length != 0 ) {
				
				}
			}
		*/	
			//trace("ss",lvlManager.houseArray.length);
			
			/*for (var i:int = 0; i < generatedRandomItemForHouse.length; i++) 
			{
				_dreamList = new DreamListComponent( String(generatedRandomItemForHouse[i]));
				arrDreamList[i] = dreamList;
				arrDreamList[i].y = 20;
				arrDreamList[i].x = i * 90;
				addChild( arrDreamList[i] );
			}*/
		}
		//end
	}
}