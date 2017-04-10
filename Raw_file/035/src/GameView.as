package  
{
	import CharData.CharaterData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import GameEvents.GameEvent;
	import Map.MapManager;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	[SWF(width='640',height='480',backgroundColor = '0x000000')]
	public class GameView extends Sprite
	{
		private var gameEngine:MapManager;
		private var charData:CharaterData;
		private var testBtn:ButtonTester = new ButtonTester();
		private var testBtn2:ButtonTester = new ButtonTester();
		
		public function GameView() 
		{
			init();
			addListener();
			addEngine();
			initTestBtn();
		}
		private function init():void {
			charData = new CharaterData();
			gameEngine = new MapManager(stage);
			gameEngine.setCharData( charData.charLevel );
		}
		private function addListener():void 
		{
			testBtn2.addEventListener(MouseEvent.CLICK, function ():void { gameEngine.gcRemoveAll();  } );
			testBtn.addEventListener(MouseEvent.CLICK, function ():void { gameEngine.setItemListSelection()  } );
			this.addEventListener( GameEvent.ON_CHARDATALVL_UPDATE, onCharLvlUpdate );
		}
		
		private function onCharLvlUpdate(e:GameEvent):void 
		{
			//On update level
			charData.updateLvl();
			gameEngine.setCharData( charData.charLevel );
		}
		
		private function addEngine():void 
		{
			addChild(gameEngine);
			addChild( testBtn );
			addChild( testBtn2 );
		}
		
		private function initTestBtn():void 
		{
			testBtn.x = 0;
			testBtn.y = -20;
			testBtn2.x = 80;
			testBtn2.y = -20;
		}
		//end
	}
}