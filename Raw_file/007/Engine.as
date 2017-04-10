package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	
	
	public class Engine extends MovieClip
	{
		private var num:Number = 0;
		private var arrB:Array = [];
		private var arrR:Array = [];
		
		public var len:Number = 5;
		private var mc:sq1;
		private var mcH:holderMC;
		
		public function Engine() {
			init();
		}
		public function init():void {
			var mcHo1:Sprite = new Sprite();
			var mcHo2:Sprite = new Sprite();
				
			
			for( var i:Number = 0; i < len; i++ ){
				mc = new sq1();
				mcH = new holderMC();
				
				arrR[ i ] = mcH;
				arrB[ i ] = mc;
				
				arrB[ i ].y = 60 * i ;
				arrR[ i ].x = 200;
				arrR[ i ].y = 70 * i ;
				arrB[ i ].index = i;
				
				arrB[ i ].addEventListener(MouseEvent.MOUSE_DOWN, onClick );
				arrB[ i ].addEventListener(MouseEvent.MOUSE_UP, onUp );
				
				
				mcHo1.addChild(arrR[ i ]);
				mcHo2.addChild(arrB[ i ]);
			}
			addChild(mcHo1);
			addChild(mcHo2);
		}
		
		private function onClick( e:Event ):void {
		 	e.currentTarget.startDrag(true);
		}
		
		private function onUp( e:Event ):void {
		 	e.currentTarget.stopDrag();
			/*for( var xx:Number=0; xx < arrB.length; xx++ ){
				if( e.currentTarget ==  arrB[xx] ){
				arrB[xx].x = arrR[xx].x;
				arrB[xx].y = arrR[xx].y;
				}
			}*/
			for( var xx:Number=0; xx < arrR.length; xx++){
					if( e.currentTarget.hitTestObject(arrR[xx]) ){
						e.currentTarget.x = arrR[xx].x;
						e.currentTarget.y = arrR[xx].y;
						trace("get bounds");
					}
			}
		}
	}
}
