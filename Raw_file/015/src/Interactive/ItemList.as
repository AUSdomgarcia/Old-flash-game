package Interactive 
{
	import flash.display.Sprite;
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
		private function initItem():void 
		{
			_bg = new IconListBg();
		}
		
		private function addItem():void 
		{
			
			for (var i:int = 0; i < 12; i++)
			{	
				_whiteBg = new WhiteBaseMc();
				_whiteBaseArr[i] = _whiteBg;
				
				componentHolder[i] = new IconComponent( _whiteBg,  i + 1, _reflist[i].state, _reflist[i].label,_reflist[i].name  );
				componentHolder[i].addBtnTrigger.addEventListener(MouseEvent.MOUSE_DOWN, onAddBtnTrigger );
				componentHolder[i].addBtnTrigger.addEventListener(MouseEvent.MOUSE_UP, onUpTrigger );
				componentHolder[i].addBtnTrigger.addEventListener(MouseEvent.MOUSE_OUT, onUpTrigger );
				
				
				_whiteBaseArr[i].x = ( _col * ( _whiteBaseArr[i].width + 20) + 25);
				_whiteBaseArr[ i ].y = (( _row * 80 ) + 60 );
				
				componentHolder[i].x = _whiteBaseArr[i].x;
				componentHolder[i].y = _whiteBaseArr[i].y;
				
				_bg.addChild( _whiteBaseArr[i] );
				_bg.addChild( componentHolder[i] );
				
				
				_col++;
				
				if ( _col > 3) { _col = 0; _row++; }
			}
			addChild( _bg );
		}
		
		private function onUpTrigger(e:MouseEvent):void 
		{
			e.currentTarget.gotoAndStop(1);
		}
		
		private function onAddBtnTrigger(e:MouseEvent):void 
		{
			e.currentTarget.gotoAndStop(2);
			trace( e.currentTarget.indexNum );
			//trace("add one! ");
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
					trace("done");
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