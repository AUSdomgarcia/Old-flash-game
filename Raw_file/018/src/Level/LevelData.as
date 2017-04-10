package Level 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class LevelData extends Sprite
	{
		public var arrData:Array = [];
		public var arrDataInv:Array = [];
		
		public function LevelData() 
		{
			
		}
		public function setLevelInvData( lvl:Number ):Array {
			arrDataInv = new Array();
			switch( lvl ) {
				case 1:
					arrDataInv = [ { state: 1 },{ state: 1 },{ state: 2 },{ state: 2 },{ state: 2 } ];
				break;
			case 2:
					arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 2 },{ state: 2 } ];
				break;
			case 3:
					arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 2 },{ state: 2 } ];
				break;
			case 4:
					arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 2 },{ state: 2 } ];
				break;
			case 5:
					arrDataInv = [ { state: 1 },{ state: 1 },{ state: 1 },{ state: 1 },{ state: 1 } ];
				break;
			}
			
			return arrDataInv;
		}
		
		public function setLevel( lvl:Number ):Array {
			arrData = new Array();
			
			switch( lvl ) {
				case 1:
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 0, label: "extra", name:"3"},
								{ state: 0, label: "toy", name:"4"},
								{ state: 0, label: "food", name:"5"},
								{ state: 0, label: "extra", name:"6"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "food", name:"8"},
								{ state: 0, label: "extra", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			case 2:
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 1, label: "extra", name:"3"},
								{ state: 1, label: "toy", name:"4"},
								{ state: 0, label: "food", name:"5"},
								{ state: 0, label: "extra", name:"6"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "food", name:"8"},
								{ state: 0, label: "extra", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			case 3:
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 1, label: "extra", name:"3"},
								{ state: 1, label: "toy", name:"4"},
								{ state: 1, label: "food", name:"5"},
								{ state: 0, label: "extra", name:"6"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "food", name:"8"},
								{ state: 0, label: "extra", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			
			case 4:
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 1, label: "extra", name:"3"},
								{ state: 1, label: "toy", name:"4"},
								{ state: 1, label: "food", name:"5"},
								{ state: 1, label: "extra", name:"6"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "food", name:"8"},
								{ state: 0, label: "extra", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;

			case 5:
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 1, label: "extra", name:"3"},
								{ state: 1, label: "toy", name:"4"},
								{ state: 1, label: "food", name:"5"},
								{ state: 1, label: "extra", name:"6"},
								{ state: 1, label: "toy", name:"7"},
								{ state: 0, label: "food", name:"8"},
								{ state: 0, label: "extra", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			
			case 6:
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 1, label: "extra", name:"3"},
								{ state: 1, label: "toy", name:"4"},
								{ state: 1, label: "food", name:"5"},
								{ state: 1, label: "extra", name:"6"},
								{ state: 1, label: "toy", name:"7"},
								{ state: 1, label: "food", name:"8"},
								{ state: 0, label: "extra", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			
			case 7:
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 1, label: "extra", name:"3"},
								{ state: 1, label: "toy", name:"4"},
								{ state: 1, label: "food", name:"5"},
								{ state: 1, label: "extra", name:"6"},
								{ state: 1, label: "toy", name:"7"},
								{ state: 1, label: "food", name:"8"},
								{ state: 1, label: "extra", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
			
			case 8:
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 1, label: "extra", name:"3"},
								{ state: 1, label: "toy", name:"4"},
								{ state: 1, label: "food", name:"5"},
								{ state: 1, label: "extra", name:"6"},
								{ state: 1, label: "toy", name:"7"},
								{ state: 1, label: "food", name:"8"},
								{ state: 1, label: "extra", name:"9"},
								{ state: 1, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
				
			case 9:
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 1, label: "extra", name:"3"},
								{ state: 1, label: "toy", name:"4"},
								{ state: 1, label: "food", name:"5"},
								{ state: 1, label: "extra", name:"6"},
								{ state: 1, label: "toy", name:"7"},
								{ state: 1, label: "food", name:"8"},
								{ state: 1, label: "extra", name:"9"},
								{ state: 1, label: "toy", name:"10"},
								{ state: 1, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
							  ];
				break;
				
			case 10:
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 1, label: "extra", name:"3"},
								{ state: 1, label: "toy", name:"4"},
								{ state: 1, label: "food", name:"5"},
								{ state: 1, label: "extra", name:"6"},
								{ state: 1, label: "toy", name:"7"},
								{ state: 1, label: "food", name:"8"},
								{ state: 1, label: "extra", name:"9"},
								{ state: 1, label: "toy", name:"10"},
								{ state: 1, label: "food", name:"11"},
								{ state: 1, label: "extra", name:"12"}
							  ];
				break;
			}
			return arrData;
		}
	//end	
	}
}