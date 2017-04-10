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
		private var _invBg:SantaBag;
		private var _whiteBase:WhiteBaseMc;
		private var _lock:LockMc;
		private var _btnMC:InvBtn;
		private var _iconList:IconList;
		public var objData:Object;
		public var strObjPass:Number = 0;
		//Boolean
		public var isOnGamePlay:Boolean;
		
		//Arrays
		public var arrLen:Array = [];
		public var refArr:Array = [];
		public var refAvailable:Array = [];
		public var btnHandlerArr:Array = [];
		public var limitHolderArr:Number = 0;
		public var imageItemHolder:Array = [];
		
		
		private var ctr:Number = 0;
		
		public function Inventory() {
			init();
		}
		private function init():void {
			_invBg = new SantaBag();
		}
		public function set invAvailable( arr:Array ):void {
			refAvailable = new Array();
			refAvailable = arr;
			setWhiteBase();
		}
		
		private function setWhiteBase():void {
			limitHolderArr = 0;
			
			for (var i:int = 0; i < 5; i++)
			{
				_whiteBase = new WhiteBaseMc();
				arrLen[ i ] = _whiteBase;
				arrLen[ i ].gotoAndStop( Number( refAvailable[i].state)  );
				
				if ( refAvailable[i].state == 1) {
					limitHolderArr++;
				}
				
				arrLen[ i ].x = 15 + ( i * ( _whiteBase.width + 10 ));
				arrLen[ i ].y = 20;
				_invBg.addChild( arrLen[ i ] );
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
					if( refArr.length != limitHolderArr ){
					refArr.push( _obj);
					trace("arrLen:", refArr.length);
					} else { trace("full na sa limit ");  }
				} else { trace("already");  }
			}
			addBtn();
		}
		
		public function addBtn():void {
			//Add btn inside inv.
			gcImageInv();
			gcBtn();
			for (var k:int = 0; k < refArr.length; k++)
			{
				_iconList = new IconList();
				_btnMC = new InvBtn();
				
				_iconList.gotoAndStop(String(refArr[k]));
				
				_btnMC.gotoAndStop(1);
				_btnMC.valueHeld = refArr[k];
				
				imageItemHolder[k] = _iconList;
				btnHandlerArr[k] = _btnMC;
				
				imageItemHolder[k].x = 20 + ( k * ( _whiteBase.width + 10 ));
				imageItemHolder[k].y = (_whiteBase.height - imageItemHolder[k].height )+ 10;
				
				btnHandlerArr[k].x = 25 + ( k * ( _whiteBase.width + 10 ));
				btnHandlerArr[k].y = (_whiteBase.height + 3);
				btnHandlerArr[ k ].addEventListener(MouseEvent.CLICK, onInvSelect);
				btnHandlerArr[ k ].addEventListener(MouseEvent.ROLL_OVER, onInvOver);
				btnHandlerArr[ k ].addEventListener(MouseEvent.ROLL_OUT, onInvOut);
				
				
				_invBg.addChild( imageItemHolder[k] );
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
					if ( _invBg.contains( arrLen[j - 1] )) 
					{
						_invBg.removeChild( arrLen[j-1] );
						arrLen.pop();
					}
				}
			}
			arrLen = new Array();
		}
		
		public function gcImageInv():void { // garbage collect button
			
			if ( imageItemHolder.length != 0 )
			{
				for (var xx:int = imageItemHolder.length ; xx > 0; xx--)
				{
					if ( _invBg.contains( imageItemHolder[xx - 1] )) {
					_invBg.removeChild( imageItemHolder[xx - 1] );
					imageItemHolder.pop();
					}
				}
				imageItemHolder = new Array();
			} else { trace("No item"); }
		}
		
		public function gcBtn():void { // garbage collect button
			
			if ( btnHandlerArr.length != 0 )
			{
				for (var xx:int = btnHandlerArr.length ; xx > 0; xx--)
				{
					if ( _invBg.contains( btnHandlerArr[xx - 1] )) {
					btnHandlerArr[xx - 1].removeEventListener(MouseEvent.ROLL_OUT, onInvOut);
					btnHandlerArr[xx - 1].removeEventListener(MouseEvent.ROLL_OVER, onInvOver);
					btnHandlerArr[xx - 1].removeEventListener(MouseEvent.CLICK, onInvSelect);
					_invBg.removeChild( btnHandlerArr[xx - 1] );
					btnHandlerArr.pop();
					}
				}
				btnHandlerArr = new Array();
			} else { trace("No item"); }
		}
		
		public function addBtnOnInv():void {
			for (var i:int = 0; i < btnHandlerArr.length; i++) 
			{
				_invBg.addChild( btnHandlerArr[i] );
			}
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
			addChild( _invBg );
		}
//end
	}
}