package Interactive 
{
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import GameEvents.GameEvent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class Inventory extends Sprite
	{
		private var bg:SantaBag;
		private var whiteBase:WhiteBaseMc;
		private var lock:LockMc;
		public var arrLen:Array = [];
		public var refHolder:Array = new Array( { state: 0, name: 0 } );
		public var refArr:Array = [];
		public var refAvailable:Array = []
		public var isOnGamePlay:Boolean;
		private var btnMC:InvBtn;
		
		public var btnHandlerArr:Array = [];
		public var validDataArr:Array = [];
		public var objData:Object;
		
		private var ctr:Number = 0;
		
		public function Inventory() {
			init();
		}
		private function init():void {
			bg = new SantaBag();
		}
		public function set invAvailable( arr:Array ):void {
			refAvailable = new Array();
			refAvailable = arr;
			setGUI();
		}
		
		public function set invData( _obj:Object ):void {
			
			if (refArr.length == 0) {
				refArr.push(_obj);
			} else {
				var isValid:Boolean = false;
				for (var i:int = 0; i < refArr.length; i++) 
				{
					if ( refArr[i] == _obj ) {
						isValid = true;
					}
				}
					
				if ( !isValid ) {
					refArr.push( _obj);
					trace("arrLen:",refArr.length);
				}
			}
			setGUI();
		}
		
		private function setGUI():void {
		//garbageCollect();
		for (var i:int = 0; i < 5; i++)
		{
			whiteBase = new WhiteBaseMc();
			arrLen[ i ] = whiteBase;
			arrLen[ i ].gotoAndStop( Number( refAvailable[i].state)  );
			arrLen[ i ].x = 15 + ( i * ( whiteBase.width + 10 ));
			arrLen[ i ].y = 20;
			bg.addChild( arrLen[ i ] );
		}
		
			//Add item inside inv.
			for (var k:int = 0; k < refArr.length; k++)
			{
				btnMC = new InvBtn();
				btnMC.gotoAndStop(2);
				btnMC.valueHeld = refArr[k];
				
				btnHandlerArr[k] = btnMC;
				btnHandlerArr[k].x = 25 + ( k * ( whiteBase.width + 10 ));
				btnHandlerArr[k].y = (whiteBase.height + 3);
				
				btnHandlerArr[ k ].addEventListener(MouseEvent.CLICK, onInvSelect);
				bg.addChild( btnHandlerArr[k] );
			}
			//addItem(); sdsd
			trace("wb", arrLen.length);
			trace("btn", btnHandlerArr.length);
		}
		
		private function garbageCollect():void {
			trace("garbage collect");
			
			if ( arrLen.length != 0 ) 
			{
				for (var j:int = arrLen.length ; j > 0; j--) 
				{
					if ( bg.contains( arrLen[j - 1] )) 
					{
						bg.removeChild( arrLen[j-1] );
						arrLen.pop();
					}
				}
			}

			if ( btnHandlerArr.length != 0 )
			{
				for (var xx:int = btnHandlerArr.length ; xx > 0; xx--) 
				{
					if ( bg.contains( btnHandlerArr[xx - 1] )) {
					btnHandlerArr[xx - 1].removeEventListener(MouseEvent.CLICK, onInvSelect);
					bg.removeChild( btnHandlerArr[xx-1] );
					btnHandlerArr.pop();
					}	
				}
			}
		}
		
		private function onInvSelect(e:MouseEvent):void 
		{
			trace("heldData:", e.target.valueHeld );
			if( this.isOnGamePlay ){			
				if ( e.currentTarget.state != 2 ) {
					this.parent.dispatchEvent( new GameEvent(GameEvent.ON_INV_SELECT));
					TweenLite.to(this, .5, { x:640, y:50 } );
				} else { trace(" epic fail "); }
			} else {
						trace("Selection Part for inventory data");
						/*for (var xx:int = 0 ; btnHandlerArr.length; xx++) 
						{
							if ( e.currentTarget == btnHandlerArr[xx] ) 
							{
								btnHandlerArr.splice( xx , 1);
								trace("dsds", btnHandlerArr.length);
								garbageCollect();
								setGUI();
							}
						}*/
				}
		}
		private function addItem():void {
			addChild( bg );
		}
//end
	}
}