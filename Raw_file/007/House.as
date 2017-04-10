package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class House extends MovieClip{
		
		private var _mcHolder:MovieClip;
		private var _stat:String;
		private var _condName:String;
		private var _pos:Number;
		
		public var isDrag:Number = false;
		/* @param 
		   condition name
		   status
		   movieClip
		   position - use array index to distinguish
		*/
		public function House( condName:String, stat:String, mc:MovieClip, pos:Number) {
			_mcHolder = mc;
			_stat = stat;
			_condName = condName;
			_pos = pos;
			init();
		}
		private function init():void {
			addItems();
			addListeners();
		}
		private function addItems():void {
			
		}
		public function removeItems():void{
			
		}
		public function removeListeners():void {
			
		}
		
		public function dragItem():void {
			_mcHolder.startDrag( false, rect );

			isDrag = true;
		}
		//end
	}
}