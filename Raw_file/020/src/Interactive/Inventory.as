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
		//Obj
		private var bg:SantaBag;
		private var whiteBase:WhiteBaseMc;
		private var lock:LockMc;
		private var btnMC:InvBtn;
		private var iconList:IconList;
		public var objData:Object;
		public var strObjPass:Number = 0;
		//Boolean
		public var isOnGamePlay:Boolean;
		
		//Arrays
		public var arrLen:Array = [];
		public var refArr:Array = [];
		public var refAvailable:Array = [];
		public var btnHandlerArr:Array = [];
		public var limitHolderArr:Array = [];
		public var imageItemHolder:Array = [];
		
		//public var refHolder:Array = new Array( { state: 0, name: 0 } );
		//public var validDataArr:Array = [];
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
			setWhiteBase();
		}
		
		private function setWhiteBase():void {
			limitHolderArr = new Array();
			
			for (var i:int = 0; i < 5; i++)
			{
				whiteBase = new WhiteBaseMc();
				arrLen[ i ] = whiteBase;
				arrLen[ i ].gotoAndStop( Number( refAvailable[i].state)  );
				
				if ( refAvailable[i].state == 1) {
					limitHolderArr[i] = "";
					trace(limitHolderArr.length);
				}
				
				arrLen[ i ].x = 15 + ( i * ( whiteBase.width + 10 ));
				arrLen[ i ].y = 20;
				bg.addChild( arrLen[ i ] );
			}
			addItem();
		}
		
		public function resetInvData():void {
			refArr = new Array();
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
					if( refArr.length != limitHolderArr.length ){
					refArr.push( _obj);
					trace("arrLen:", refArr.length);
					} else { trace("full na sa limit ");  }
				} else { trace("already");  }
			}
			addBtn();
		}
		
		public function addBtn():void {
			//Add item inside inv.
			gcBtn();
			for (var k:int = 0; k < refArr.length; k++)
			{
				iconList = new IconList();
				btnMC = new InvBtn();
				
				iconList.gotoAndStop(String(refArr[k]));
				
				btnMC.gotoAndStop(1);
				btnMC.valueHeld = refArr[k];
				
				imageItemHolder[k] = iconList;
				btnHandlerArr[k] = btnMC;
				
				imageItemHolder[k].x = 20 + ( k * ( whiteBase.width + 10 ));
				imageItemHolder[k].y = (whiteBase.height - imageItemHolder[k].height )+ 10;
				
				btnHandlerArr[k].x = 25 + ( k * ( whiteBase.width + 10 ));
				btnHandlerArr[k].y = (whiteBase.height + 3);
				btnHandlerArr[ k ].addEventListener(MouseEvent.CLICK, onInvSelect);
				btnHandlerArr[ k ].addEventListener(MouseEvent.ROLL_OVER, onInvOver);
				btnHandlerArr[ k ].addEventListener(MouseEvent.ROLL_OUT, onInvOut);
				
				
				bg.addChild( imageItemHolder[k] );
				bg.addChild( btnHandlerArr[k] );
			}
			addItem();
		}
		
		private function onInvOut(e:MouseEvent):void 
		{
			if( this.isOnGamePlay ){
			e.currentTarget.gotoAndStop(1);
			}
		}
		
		private function onInvOver(e:MouseEvent):void 
		{
			if( this.isOnGamePlay ){
			e.currentTarget.gotoAndStop(2);
			}
		}
		
		public function gcWhitebase():void { //garbageCollect
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
			arrLen = new Array();
		}
		
		public function gcBtn():void { // garbage collect button
			
			if ( btnHandlerArr.length != 0 )
			{
				for (var xx:int = btnHandlerArr.length ; xx > 0; xx--) 
				{
					if ( bg.contains( btnHandlerArr[xx - 1] )) {
					btnHandlerArr[xx-1].removeEventListener(MouseEvent.ROLL_OUT, onInvOut);
					btnHandlerArr[xx - 1].removeEventListener(MouseEvent.CLICK, onInvSelect);
					bg.removeChild( btnHandlerArr[xx - 1] );
					bg.removeChild( imageItemHolder[xx - 1] );
					btnHandlerArr.pop();
					imageItemHolder.pop();
					}
				}
				imageItemHolder = new Array();
				btnHandlerArr = new Array();
			} else { trace("No item"); }
		}
		
	
		private function onInvSelect(e:MouseEvent):void 
		{
			if ( this.isOnGamePlay ) {		
				
					var obj:Object = new Object();
					obj.str = e.target.valueHeld;
					this.parent.dispatchEvent( new GameEvent(GameEvent.ON_INV_SELECT, obj ));
					TweenLite.to(this, .5, { x:640, y:50 } );
				//} else { trace(" epic fail "); }
			} else {
					trace("not in the game yet");
					trace("heldData:", e.target.valueHeld );
			}
		}
		private function addItem():void {
			addChild( bg );
		}
//end
	}
}