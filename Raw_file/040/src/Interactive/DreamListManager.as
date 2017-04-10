package Interactive 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
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
			trace(this,"ArrItem:",arrItem.length,"ArrHouse.Length",arrHouse.length);
			randomItemArr = arrItem;
			generateDreamComponent();
		}
		
		private function generateDreamComponent():void
		{
			for (var i:int = 0; i < randomItemArr.length; i++)
			{
				_dreamList = new DreamListComponent( randomItemArr[i] );
				_dreamListArray[i] = _dreamList;
				_dreamListArray[i].setRandomMax( randomNum );
			}
			
			var numLen:Number = _dreamListArray.length;
			trace( _dreamListArray.length );
			
			for (var j:int = 0; j < numLen; j++)
			{
				var num:Number = Math.floor( Math.random() * houseRefArr.length );
				houseRefArr[num].heldDreamListArr.push( _dreamListArray.splice( j, 1 ));
				numLen--;
			}
			trace( _dreamListArray.length );
			
		/*	for (var k:int = 0; k < _dreamListArray.length; k++) 
			{
				var num:Number = Math.floor( Math.random() * _dreamListArray.length );
				houseRefArr[k].heldDreamListArr.push( _dreamListArray.splice( num, 1 ));
				if ( _dreamListArray.length != 0 ) {
				
				}
			}
		*/	
			for (var l:int = 0; l < houseRefArr.length; l++) 
			{
				trace( "final ",houseRefArr[l].heldDreamListArr.length );
			}
		}
		
		public function starDistribution( e:TimerEvent ):void {
			
		}
		
		private function notInclude():void{
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
		
	}

}