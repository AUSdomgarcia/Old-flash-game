package Interactive 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class ItemList extends Sprite
	{
		//Graphic UI
		private var _bg:IconListBg;
		private var _whiteBg:WhiteBaseMc;
		
		//Functional variable
		public var arrLen:Array = [];
		public var componentHolder:Array = [];
		private var _reflist:Array = [];
		
		private var ctr:Number = 0;
		
		private var _whiteBaseArr:Array = [];
		private var _row:Number = 0;
		private var _col:Number = 0;
		
		public function ItemList() 
		{
			initItem();
			addListener();
		}
		
		private function addListener():void 
		{
			_bg.done.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			_bg.reset.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			_bg.done.addEventListener(MouseEvent.MOUSE_UP , onUP);
			_bg.reset.addEventListener(MouseEvent.MOUSE_UP , onUP);
		}
		
		public function set setrefList( refList:Array ):void {
			_reflist = refList;
			addItem();
		}
		
		public function clearAll():void 
		{
			for (var i:int = 0; i < _whiteBaseArr.length; i++) 
			{	
				if ( _whiteBaseArr.length != 0 ) {
					_bg.removeChild( _whiteBaseArr[i] );
					componentHolder[i].addBtnTrigger.removeEventListener(MouseEvent.MOUSE_DOWN, onAddBtnTrigger );
					componentHolder[i].addBtnTrigger.removeEventListener(MouseEvent.MOUSE_UP, onUpTrigger );
					componentHolder[i].addBtnTrigger.removeEventListener(MouseEvent.MOUSE_OUT, onUpTrigger );
				
					componentHolder[i].removeItem();
					_bg.removeChild( componentHolder[i] );
				}	
			}
			trace("clearAll", componentHolder.length );
			componentHolder = new Array();
			_whiteBaseArr = new Array();
		}
		
		private function initItem():void 
		{
			_bg = new IconListBg();
		}
		
		private function addItem():void 
		{	
			ctr += 10;
			trace("addItem", componentHolder.length );
			
			_row = 0;
			_col = 0;
			addChild( _bg );
			for (var i:int = 0; i < 12; i++)
			{	
				_whiteBaseArr[i] = new WhiteBaseMc();
			
				
				componentHolder[i] = new IconComponent( _whiteBaseArr[i],  i + 1, _reflist[i].state, _reflist[i].label,_reflist[i].name  );
				componentHolder[i].addBtnTrigger.addEventListener(MouseEvent.MOUSE_DOWN, onAddBtnTrigger );
				componentHolder[i].addBtnTrigger.addEventListener(MouseEvent.MOUSE_UP, onUpTrigger );
				componentHolder[i].addBtnTrigger.addEventListener(MouseEvent.MOUSE_OUT, onUpTrigger );
				
				
				_whiteBaseArr[i].x = ( _col * ( _whiteBaseArr[i].width + 20) + (25 + ctr ) );
				_whiteBaseArr[ i ].y = (( _row * 80 ) + 60 );
				_bg.addChild( _whiteBaseArr[ i ] );
				
				componentHolder[i].x = _whiteBaseArr[i].x;
				componentHolder[i].y = _whiteBaseArr[i].y;
				_bg.addChild( componentHolder[i] );
				
				_col++;
				
				if ( _col > 3) { _col = 0; _row++; }
			}
		}
		
		private function onUpTrigger(e:MouseEvent):void 
		{
			e.currentTarget.gotoAndStop(1);
		}
		
		private function onAddBtnTrigger(e:MouseEvent):void 
		{
			e.currentTarget.gotoAndStop(2);
			trace( e.currentTarget.indexNum );
		}
		
		private function onUP(e:MouseEvent):void 
		{
			switch( e.currentTarget.name ) {
				case "done":
					e.currentTarget.gotoAndStop(1);
				break;
			case "reset":
					e.currentTarget.gotoAndStop(1);
				break;
			}
		}
		
		private function onDown(e:MouseEvent):void 
		{
			switch( e.currentTarget.name ) {
				case "done":
					e.currentTarget.gotoAndStop(2);
					clearAll();
					this.parent.dispatchEvent( new Event("ON_DONE") );
					break;
			case "reset":
					e.currentTarget.gotoAndStop(2);
					trace("reset");
				break;
			}
		}
	//end	
	}
}