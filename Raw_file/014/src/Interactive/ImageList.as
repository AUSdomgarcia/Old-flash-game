package Interactive 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author domz
	 */
	public class ImageList extends Sprite
	{
		public var refList:Array = [];
		public var imageArray:Array = [];
		private var _mcBg:IconListBg;
		private var _spt:Sprite = new Sprite();
		private var _len:Number = 0;
		
		public function ImageList() 
		{
			
		}
		public function set setrefList( _refList:Array ):void {
			refList = _refList;
			_mcBg = new IconListBg();
			var col:Number = 0;
			var row:Number = 0;
			
			_len = refList.length;
			trace("arr len", _len );
			for (var i:int = 0; i < _len; i++)
			{	
				imageArray[i] = new IconComponent( i + 1, refList[i].state, refList[i].label );
				imageArray[ i ].x = ( col * ( imageArray[i].width + 20 ) + 30 );
				imageArray[ i ].y = (( row * 70 )+ 30 );
				
				_spt.addChild( imageArray[i] );
				col++;
				imageArray[ i ].addEventListener(MouseEvent.CLICK, onClick );
				if (col > 3) { col = 0; row++; }
			}
			addItem();
		}
		
		public function addItem():void {
			_mcBg.addChild( _spt );
			addChild( _mcBg );
		}
		
		private function onClick( e:MouseEvent ):void {
			trace( e.currentTarget.label );
		}
	//end
	}
}